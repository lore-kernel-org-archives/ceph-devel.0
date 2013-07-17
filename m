From: Hemanth Kumar <hemanthkumar51@gmail.com>
Subject: Fwd: Error while running teuthology
Date: Wed, 17 Jul 2013 11:54:47 +0530
Message-ID: <CAG_LFoC9vErfwQ+Ggkaps7r2L2G36z4Gw3=CM0TnDnjwayiqhA@mail.gmail.com>
References: <CAG_LFoCDv8NvzuzQrutUBgb+yDocfuP89EYKqaat3321LcNfzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58031 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab3GQGYs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jul 2013 02:24:48 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so3280279ieb.30
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jul 2013 23:24:47 -0700 (PDT)
In-Reply-To: <CAG_LFoCDv8NvzuzQrutUBgb+yDocfuP89EYKqaat3321LcNfzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am beginner and would like to contribute ceph-qa
I amtrying to run teuthology with 1 server-node and 1 client-node, i
am stuck with an error can any one point out the mistake i am doing

following is my ceph configuration:
I have 1 server : ceph-server 192.168.100.102 with ceph cludter
[mon.a, mds.a, osd.1, osd.2]
1 client : 192.168.100.103 with configured RBD n CEPFS

root@ceph-node1:~/testing/teuthology# nano test.yaml
root@ceph-node1:~/testing/teuthology# ./virtualenv/bin/teuthology test.yaml
INFO:teuthology.run_tasks:Running task internal.save_config...
INFO:teuthology.task.internal:Saving configuration
INFO:teuthology.run_tasks:Running task internal.check_lock...
INFO:teuthology.task.internal:Lock checking disabled.
INFO:teuthology.run_tasks:Running task internal.connect...
INFO:teuthology.task.internal:Opening connections...
INFO:teuthology.task.internal:roles: ceph@ceph-server - ['mon.a',
'mds.a', 'osd.0', 'osd.1']
INFO:teuthology.run_tasks:Running task internal.check_conflict...
INFO:teuthology.task.internal:Checking for old test directory...
ERROR:teuthology.run_tasks:Saw exception from tasks
Traceback (most recent call last):
  File "/root/testing/teuthology/teuthology/run_tasks.py", line 25, in run_tasks
    manager = _run_one_task(taskname, ctx=ctx, config=config)
  File "/root/testing/teuthology/teuthology/run_tasks.py", line 14, in
_run_one_task
    return fn(**kwargs)
  File "/root/testing/teuthology/teuthology/task/internal.py", line
254, in check_conflict
    testdir = teuthology.get_testdir(ctx)
  File "/root/testing/teuthology/teuthology/misc.py", line 42, in get_testdir
    status = lockstatus.get_status(ctx, machine)
  File "/root/testing/teuthology/teuthology/lockstatus.py", line 25,
in get_status
    return json.loads(content)
  File "/usr/lib/python2.7/json/__init__.py", line 326, in loads
    return _default_decoder.decode(s)
  File "/usr/lib/python2.7/json/decoder.py", line 366, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib/python2.7/json/decoder.py", line 384, in raw_decode
    raise ValueError("No JSON object could be decoded")
ValueError: No JSON object could be decoded
INFO:teuthology.run:Summary data:
{failure_reason: No JSON object could be decoded, owner:
root@ceph-node1, success: false}

INFO:teuthology.run:FAIL

test.yaml

check-locks: false
roles:
- [mon.a, mds.a, osd.0, osd.1]
targets:
  ceph@ceph-server: ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAABAQC18Vm9HABtFv2BjuFNFxLSwJH0ZcP0pzhJJUTCLQ/181osbhNP0kkqMWaoddjmNNdvpBY6YMvM06GlE3TdMkF$
tasks:
- install:
- ceph:
- interactive:

--
Thanks,
Hemanth Kumar H C



--
Thanks,
Hemanth Kumar H C
