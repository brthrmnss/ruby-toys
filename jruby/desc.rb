require 'java'

#~ $CLASSPATH << "C:\\Users\\user1\\j2ee_workspace\\CertTests\\bin"#\\other";
#~ $CLASSPATH << "C:\\Users\\user1\\j2ee_workspace\\CertTests\\bin\\other";
$CLASSPATH << "C:/Users/user1/j2ee_workspace/CertTests/bin";
java_import 'other.TestExec2';
import 'other.TestExec2';
 puts TestExec2
 
 class Printer
	 
	def println asdf
		puts asdf
	end
	
	def println()
		puts asdf
	end
end
o = Printer.new()
 TestExec2.o = o
 TestExec2.main([])
 
exit()

java_import java.awt.BorderLayout
java_import java.awt.Button
java_import java.awt.FlowLayout
java_import java.awt.Frame
java_import java.awt.Panel
# Events
java_import java.awt.event.ActionListener
java_import java.awt.event.WindowAdapter
java_import java.lang.System

class ToolbarFrame1 < Frame

  def initialize()
    super("Toolbar Example (AWT)")
    size = 450, 250
    add_window_listener(WindowCloser.new)

    toolbar = Panel.new
    toolbar.layout = FlowLayout.new(FlowLayout::LEFT)
    cut = Button.new("Cut")
    cut.add_action_listener(PrintListener.new)
    toolbar.add(cut)

    copy = Button.new("Copy")
    copy.add_action_listener(PrintListener.new)
    toolbar.add(copy)

    paste = Button.new("Paste")
    paste.add_action_listener(PrintListener.new)
    toolbar.add(paste)

    add(toolbar, BorderLayout::NORTH)
  end

  class WindowCloser < WindowAdapter
    def window_closing
      System.exit()
    end
  end

  class PrintListener
    include ActionListener
    def action_performed(event)
      System.out.println(event.action_command)
    end
  end

end

tf1 = ToolbarFrame1.new
tf1.visible = true