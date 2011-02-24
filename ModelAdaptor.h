/**
 * An object that knows how to convert property references to appropriate
 * actions on a model object.  Some models, like JDBC, are interface based
 * (we aren't supposed to care about implementation classes). Some other
 * models don't follow getter method naming convention.  So, if we have
 * an object of type M with property method foo() (not getFoo()), we
 * register a model adaptor object, adap, that converts foo lookup to foo().
 * 
 * Given <a.foo>, we look up foo via the adaptor if "a instanceof(M)".
 * 
 * See unit tests.
 */
@class ST;

@protocol ModelAdaptor <NSObject>
- (id) getProperty:(ST *)aWho obj:(id)anObj property:(id)aProperty propertyName:(NSString *)aPropertyName;
@end
