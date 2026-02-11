---
layout: post
title: "DSPy: Programming—not prompting—Foundation Models. A Brief Intro"
categories: []
tags: [agent-dev, prompt-tuning, code-gen]
---



![fig1.png](assets/img/openevolve/fig1.png)


![fig2.png](assets/img/openevolve/fig2.png)

![fig3.png](assets/img/openevolve/fig3.png)





- Since evaluator should make use of full system resources, we may need to:
  1. Run only one island
  2. Have a global locking mechanism, but anything running in parallel would still be consuming system resources, thus contributing noise and leading to inaccurate evaluation
  3. If the host system has more resources than target system, then run evaluation in cgroup
  4. Run evaluation remotely
- Even if we run in one island, there seems to be noise (might be due to codex waiting for command to complete), and the codex measured evaluation results and manually measured evaluation results are different

![fig4.png](assets/img/openevolve/fig4.png)

