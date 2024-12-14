### Motion Control in Computer-Aided Modeling

Computer-aided modeling and manufacturing require precise control of spatial position along a prescribed motion path. We will illustrate the use of Adaptive Quadrature to solve a fundamental piece of the problem: equi-partition, or the division of an arbitrary path into equal-length subpaths.

In numerical machining problems, it is preferable to maintain constant speed along the path. During each second, progress should be made along an equal length of the machine–material interface. In other motion planning applications, including computer animation, more complicated progress curves may be required. For example:

- A hand reaching for a doorknob might begin and end with low velocity and have higher velocity in between.
- Robotics and virtual reality applications require the construction of parametrized curves and surfaces to be navigated.

Building a table of small equal increments in path distance is often a necessary first step.

---

#### Parametric Path Description

Assume that a parametric path $$ P = \{x(t), y(t)\} \, | \, 0 \leq t \leq 1 $$ is given. Figure 5.6 shows the example path:

$$
\begin{aligned}
x(t) &= 0.5 + 0.3t + 3.9t^2 - 4.7t^3, \\
y(t) &= 1.5 + 0.3t + 0.9t^2 - 2.7t^3.
\end{aligned}
$$

This is the Bézier curve defined by the four points:

- (0.5, 1.5),
- (0.6, 1.6),
- (2, 2),
- (0, 0).

(See Section 3.5 for Bézier curve details.) Points defined by evenly spaced parameter values $$ t = 0, 1/4, 1/2, 3/4, 1 $$ are shown. Note that even spacing in parameter does not imply even spacing in arc length.

---

#### Problem Objective

Your goal is to apply quadrature methods to divide this path into $$ n $$ equal lengths.

---

#### Arc Length Formula

Recall from calculus that the arc length of the path from $$ t_1 $$ to $$ t_2 $$ is given by:

$$
\int_{t_1}^{t_2} \sqrt{x'(t)^2 + y'(t)^2} \, dt.
$$

Only rarely does the integral yield a closed-form expression, and normally an Adaptive Quadrature technique is used to control the parametrization of the path.


### Suggested Activities:

1. Write a MATLAB function that uses Adaptive Quadrature to compute the arc length from 
	$$ t = 0 $$ to $$ t = T $$ for a given $$ T \leq 1 $$.

2. Write a program that, for any input $$ s $$ between 0 and 1, finds the parameter $$ t^*(s) $$ that is $$ s $$
	of the way along the curve. In other words, the arc length from $$ t = 0 $$ to $$ t = t^*(s) $$ divided
	by the arc length from $$ t = 0 $$ to $$ t = 1 $$ should be equal to $$ s $$. Use the Bisection Method to 
	locate the point $$ t^*(s) $$ to three correct decimal places. What function is being set to zero?
	What bracketing interval should be used to start the Bisection Method?

3. Equipartition the path of Figure 5.6 into $$ n $$ subpaths of equal length, for $$ n = 4 $$ and $$ n = 20 $$.
	Plot analogues of Figure 5.6, showing the equipartitions. If your computations are too slow, consider
	speeding up the Adaptive Quadrature with Simpson’s Rule, as suggested in Computer Problem 5.4.2.

4. Replace the Bisection Method in Step 2 with Newton’s Method, and repeat Steps 2 and 3. What is the derivative
	needed? What is a good choice for the initial guess? Is computation time decreased by this replacement?

5. Appendix A demonstrates animation commands available in MATLAB. For example, the commands

	```matlab
	set(gca, 'XLim', [-2 2], 'YLim', [-2 2], 'Drawmode', 'fast',...
	    'Visible', 'on');
	cla
	axis square
	```

	define an object “ball” that is assigned position $$(x, y)$$ by the following commands:

	```matlab
	set(ball, 'xdata', x, 'ydata', y); drawnow; pause(0.01)
	```

	Putting this line in a loop that changes $$ x $$ and $$ y $$ causes the ball to move along the path in the
	MATLAB figure window. 

	Use MATLAB’s animation commands to demonstrate traveling along the path, first at the 
	original parameter $$ 0 \leq t \leq 1 $$ speed and then at the (constant) speed given by $$ t^*(s) $$ for 
	$$ 0 \leq s \leq 1 $$.

6. Experiment with equipartitioning a path of your choice. Build a design, initial, etc. of your choice out of Bézier
	curves, partition it into equal arc length segments, and animate as in Step 5.

7. Write a program that traverses the path $$ P $$ according to an arbitrary progress curve $$ C(s) $$,
	$$ 0 \leq s \leq 1 $$, with $$ C(0) = 0 $$ and $$ C(1) = 1 $$. The object is to move along the curve $$ C $$ in 
	such a way that the proportion $$ C(s) $$ of the path’s total arc length is traversed between $$ 0 $$ and $$ s $$.
	For example, constant speed along the path would be represented by $$ C(s) = s $$. Try progress curves
	$$ C(s) = s^{1/3} $$, $$ C(s) = s^2 $$, $$ C(s) = \sin(\pi s / 2) $$, or 
	$$ C(s) = 1/2 + (1/2)\sin(2s - 1)\pi / 2 $$, for example.

	Consult Wang et al. [2003] and Guenter and Parent [1990] for more details and applications of reparametrization of curves in the plane and space.