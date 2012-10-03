From: Pradeep S <pradeeps192@gmail.com>
Subject: error: could not read lock status
Date: Wed, 3 Oct 2012 18:11:33 +0530
Message-ID: <CAB0Uiv0-k0zgS5yTj23uXdU8W5t9ejwYVCs+9XhqWC14+PKrWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59894 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab2JCMle (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 08:41:34 -0400
Received: by eekb15 with SMTP id b15so3954851eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 05:41:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi, i am getting the following error while executing ceph-qa-suite in
teuthology.
INFO:teuthology.run_tasks:Running task internal.save_config...
INFO:teuthology.task.internal:Saving configuration
INFO:teuthology.run_tasks:Running task internal.check_lock...
INFO:teuthology.task.internal:Checking locks...
INFO:teuthology.lock:GET request to
'http://pradeep:4000/lock/pradeep@pradeep.com' with body 'None' failed
with response code 404
ERROR:teuthology.run_tasks:Saw exception from tasks
Traceback (most recent call last):
  File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/run_tasks.py",
line 25, in run_tasks
    manager = _run_one_task(taskname, ctx=ctx, config=config)
  File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/run_tasks.py",
line 14, in _run_one_task
    return fn(**kwargs)
  File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/task/internal.py",
line 110, in check_lock
    'could not read lock status for {name}'.format(name=machine)
AssertionError: could not read lock status for pradeep@pradeep.com

The conf file is: lock_server: http://pradeep:4000/lock.

With thanks
Pradeep S
