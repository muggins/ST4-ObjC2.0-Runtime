#import "STViewFrame.h"

@implementation STViewFrame

- (id) init
{
  self = [super init];
  if ( self ) {
    [self initComponents];
  }
  return self;
}

- (void) initComponents
{
  toolBar1 = [[[JToolBar alloc] init] autorelease];
  treeContentSplitPane = [[[NSSplitView alloc] init] autorelease];
  treeAttributesSplitPane = [[[NSSplitView alloc] init] autorelease];
  treeScrollPane = [[[NSScrollView alloc] init] autorelease];
  tree = [[[JTree alloc] init] autorelease];
  attributeScrollPane = [[[NSScrollView alloc] init] autorelease];
  attributes = [[[JTree alloc] init] autorelease];
  outputTemplateSplitPane = [[[NSSplitView alloc] init] autorelease];
  scrollPane7 = [[[NSScrollView alloc] init] autorelease];
  output = [[[NSTextView alloc] init] autorelease];
  templateBytecodeTraceTabPanel = [[[JTabbedPane alloc] init] autorelease];
  panel1 = [[[JPanel alloc] init] autorelease];
  scrollPane3 = [[[NSScrollView alloc] init] autorelease];
  template = [[[NSTextView alloc] init] autorelease];
  scrollPane2 = [[[NSScrollView alloc] init] autorelease];
  ast = [[[JTree alloc] init] autorelease];
  scrollPane15 = [[[NSScrollView alloc] init] autorelease];
  bytecode = [[[NSTextView alloc] init] autorelease];
  scrollPane1 = [[[NSScrollView alloc] init] autorelease];
  trace = [[[NSTextView alloc] init] autorelease];
  errorScrollPane = [[[NSScrollView alloc] init] autorelease];
  errorList = [[[JList alloc] init] autorelease];
  Container * contentPane = [self contentPane];
  [contentPane setLayout:[[[GridBagLayout alloc] init] autorelease]];
  ((GridBagLayout *)[contentPane layout]).columnWidths = [NSArray arrayWithObjects:0, 0, nil];
  ((GridBagLayout *)[contentPane layout]).rowHeights = [NSArray arrayWithObjects:0, 0, 0, 0, nil];
  ((GridBagLayout *)[contentPane layout]).columnWeights = [NSArray arrayWithObjects:1.0, 1.0E-4, nil];
  ((GridBagLayout *)[contentPane layout]).rowWeights = [NSArray arrayWithObjects:0.0, 1.0, 0.0, 1.0E-4, nil];
  [contentPane add:toolBar1 param1:[[[GridBagConstraints alloc] init:0 param1:0 param2:1 param3:1 param4:0.0 param5:0.0 param6:GridBagConstraints.CENTER param7:GridBagConstraints.BOTH param8:[[[Insets alloc] init:0 param1:0 param2:0 param3:0] autorelease] param9:0 param10:0] autorelease]];
  {
    [treeContentSplitPane setResizeWeight:0.25];
    {
      [treeAttributesSplitPane setOrientation:NSSplitView.VERTICAL_SPLIT];
      [treeAttributesSplitPane setResizeWeight:0.7];
      {
        [treeScrollPane setViewportView:tree];
      }
      [treeAttributesSplitPane setTopComponent:treeScrollPane];
      {
        [attributeScrollPane setViewportView:attributes];
      }
      [treeAttributesSplitPane setBottomComponent:attributeScrollPane];
    }
    [treeContentSplitPane setLeftComponent:treeAttributesSplitPane];
    {
      [outputTemplateSplitPane setOrientation:NSSplitView.VERTICAL_SPLIT];
      [outputTemplateSplitPane setResizeWeight:0.7];
      {
        [scrollPane7 setViewportView:output];
      }
      [outputTemplateSplitPane setTopComponent:scrollPane7];
      {
        {
          [panel1 setLayout:[[[BoxLayout alloc] init:panel1 param1:BoxLayout.X_AXIS] autorelease]];
          {
            [scrollPane3 setViewportView:template];
          }
          [panel1 add:scrollPane3];
          {
            [scrollPane2 setViewportView:ast];
          }
          [panel1 add:scrollPane2];
        }
        [templateBytecodeTraceTabPanel addTab:@"template" param1:panel1];
        {
          [scrollPane15 setViewportView:bytecode];
        }
        [templateBytecodeTraceTabPanel addTab:@"bytecode" param1:scrollPane15];
        {
          [scrollPane1 setViewportView:trace];
        }
        [templateBytecodeTraceTabPanel addTab:@"trace" param1:scrollPane1];
      }
      [outputTemplateSplitPane setBottomComponent:templateBytecodeTraceTabPanel];
    }
    [treeContentSplitPane setRightComponent:outputTemplateSplitPane];
  }
  [contentPane add:treeContentSplitPane param1:[[[GridBagConstraints alloc] init:0 param1:1 param2:1 param3:1 param4:0.0 param5:0.0 param6:GridBagConstraints.CENTER param7:GridBagConstraints.BOTH param8:[[[Insets alloc] init:0 param1:0 param2:0 param3:0] autorelease] param9:0 param10:0] autorelease]];
  {
    [errorScrollPane setViewportView:errorList];
  }
  [contentPane add:errorScrollPane param1:[[[GridBagConstraints alloc] init:0 param1:2 param2:1 param3:1 param4:0.0 param5:0.0 param6:GridBagConstraints.CENTER param7:GridBagConstraints.BOTH param8:[[[Insets alloc] init:0 param1:0 param2:0 param3:0] autorelease] param9:0 param10:0] autorelease]];
  [self pack];
  [self setLocationRelativeTo:[self owner]];
}

- (void) dealloc
{
  [toolBar1 release];
  [treeContentSplitPane release];
  [treeAttributesSplitPane release];
  [treeScrollPane release];
  [tree release];
  [attributeScrollPane release];
  [attributes release];
  [outputTemplateSplitPane release];
  [scrollPane7 release];
  [output release];
  [templateBytecodeTraceTabPanel release];
  [panel1 release];
  [scrollPane3 release];
  [template release];
  [scrollPane2 release];
  [ast release];
  [scrollPane15 release];
  [bytecode release];
  [scrollPane1 release];
  [trace release];
  [errorScrollPane release];
  [errorList release];
  [super dealloc];
}

@end
