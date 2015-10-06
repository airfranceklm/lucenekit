//
//  LCKViewController.m
//  LuceneKit
//
//  Created by Laurent Gaches on 09/21/2015.
//  Copyright (c) 2015 Laurent Gaches. All rights reserved.
//

#import "LCKViewController.h"

#include "LuceneKit/LuceneHeaders.h"
#include "FileUtils.h"
#include "MiscUtils.h"
#include "Constants.h"

using namespace Lucene;




@interface LCKViewController ()

@end

@implementation LCKViewController

int32_t docNumber = 0;

+(NSString *)stringFromWchar:(const wchar_t *)charText
{
    //used ARC
    return [[NSString alloc] initWithBytes:charText length:wcslen(charText)*sizeof(*charText) encoding:NSUTF32LittleEndianStringEncoding];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    testLucenePP();
}


void testLucenePP() {
    
    
    
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    String path(StringUtils::toUnicode([[paths[0] path] UTF8String]));
    
    
    
    
    AnalyzerPtr analyzer = newLucene<StandardAnalyzer>(LuceneVersion::Version::LUCENE_30);
    
    
    IndexWriterPtr indexWriter = newLucene<IndexWriter>(FSDirectory::open(path) ,analyzer,true, IndexWriter::DEFAULT_MAX_FIELD_LENGTH);
    DocumentPtr doc = newLucene<Document>();
    
    
    doc->add(newLucene<Field>(L"fieldname", L"This is the text to be indexed.",Field::STORE_YES, Field::INDEX_ANALYZED));
    
    indexWriter->addDocument(doc);
    indexWriter->close();
    
    
    IndexReaderPtr reader = IndexReader::open(FSDirectory::open(path));
    SearcherPtr searcher = newLucene<IndexSearcher>(reader);
    QueryParserPtr parser = newLucene<QueryParser>(LuceneVersion::Version::LUCENE_30,L"fieldname",analyzer);
    
    QueryPtr query = parser->parse(L"text");
    NSLog(@"%@", [LCKViewController stringFromWchar:query->toString(L"fieldname").c_str()]);
    
    TopDocsPtr topdocs =  searcher->search(query, 1000);
    NSLog(@"%d", topdocs->totalHits);
    
    Collection<ScoreDocPtr> hits = searcher->search(query, 1000)->scoreDocs;
    
    for (int i = 0; i < hits.size(); i++) {
        DocumentPtr hitDoc = searcher->doc(hits[i]->doc);
        
        
        std::wcout << L"Text: " << hitDoc->get(L"fieldname") << L"\n";
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
