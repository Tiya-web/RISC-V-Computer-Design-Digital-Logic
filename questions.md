

# Question 1: Again, imagine a friend of yours will be taking this course next semester. You want them to help them learn without unnecessary struggle or stress. What suggestions or tips would you give them about this assignment?

TODO: Start working on the assignments early and make heavy use of the TAs during office hours, especially for debugging tricky Verilog issues. A key struggle is correctly implementing pseudo-instructions: manually translate complex assembly shortcuts like call and li into their base instructions (auipc/jalr, addi/lui) to ensure the final machine code adheres strictly to the supported instruction set

# Question 2: Briefly summarize how you would approach adding another instruction to the processor?  (At a generic, high-level, explain the steps you'd follow)

TODO : The process begins with an analysis of the instruction's operation to identify its resource needs, such as whether it needs a new ALU function or a new data path for the Program Counter. Once analyzed, I would first update the maindec controller to generate the specific control signals required by the instruction's opcode, and then modify or expand multiplexers in the datapath to route the data accordingly.

# Question 3: Summarize how low-level logic can be combined to build large, complex devices.

TODO : Large, complex devices like a CPU are built hierarchically by combining two fundamental types of logic: combinational and sequential. Combinational elements, such as the ALU and multiplexers, perform immediate operations without memory, while sequential elements, like registers and the Program Counter, provide synchronized memory storage controlled by the clock. The controller then acts as the central command unit, using the current instruction to orchestrate the actions of all low-level components, enabling the execution of complex programs one step at a time.

# Question 4: How do you feel this course has contributed to your understanding of digital devices and computers so far?

TODO :I've learned so much, and it's certainly deepened my fundamental understanding of digital design, FPGA synthesis, and the RISC-V architecture. Specifically, the assignment provided crucial insight into the intimate relationship between high-level assembly language (software) and the precise behavior required of the underlying hardware structure (Verilog).

# Question 5: Please give a rough estimate of the time this assignment took you and your overall effort.

TODO : This assignment took approximately 20 hours of focused effort spread across multiple days. The majority of the time was spent on debugging.
