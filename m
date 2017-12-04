From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Assertion failed while buildign manpages
Date: Mon, 4 Dec 2017 21:22:26 +0100
Message-ID: <6899bf17-d2cd-8088-97fe-0a23d001b6dc@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:27568 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752466AbdLDUW2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Dec 2017 15:22:28 -0500
Received: from [192.168.11.152] (unknown [192.168.11.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 879BC2E0BC
        for <ceph-devel@vger.kernel.org>; Mon,  4 Dec 2017 21:22:25 +0100 (CET)
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

My FreeBSD-Jenkins complains about a failed assertion, but I'm 
blissfully ignorant in this matter.
So perhaps somebody has hints to fix this.

--WjW


Build output:
Running Sphinx v1.4.8

Exception occurred:
   File "conf.py", line 27, in _get_description
AssertionError
The full traceback has been saved in /tmp/sphinx-err-_Gk2q9.log, if you 
want to report the issue to the developers.
Please also report this if it was a user error, so that a better error 
message can be provided next time.
A bug report can be filed in the tracker at 
<https://github.com/sphinx-doc/sphinx/issues>. Thanks!
gmake[2]: *** [doc/man/CMakeFiles/manpages.dir/build.make:137: 
doc/man/ceph-syn.8] Error 1

The log file looks like:
# Sphinx version: 1.4.8
# Python version: 2.7.14 (CPython)
# Docutils version: 0.14
# Jinja2 version: 2.10
# Last messages:

# Loaded extensions:
Traceback (most recent call last):
   File "/usr/local/lib/python2.7/site-packages/sphinx/cmdline.py", line 
243, in main
     opts.warningiserror, opts.tags, opts.verbosity, opts.jobs)
   File "/usr/local/lib/python2.7/site-packages/sphinx/application.py", 
line 137, in __init__
     confoverrides or {}, self.tags)
   File "/usr/local/lib/python2.7/site-packages/sphinx/config.py", line 
287, in __init__
     execfile_(filename, config)
   File 
"/usr/local/lib/python2.7/site-packages/sphinx/util/pycompat.py", line 
130, in execfile_
     exec_(code, _globals)
   File "/usr/local/lib/python2.7/site-packages/six.py", line 709, in exec_
     exec("""exec _code_ in _globs_, _locs_""")
   File "<string>", line 1, in <module>
   File "conf.py", line 56, in <module>
   File "conf.py", line 47, in _get_manpages
   File "conf.py", line 27, in _get_description
AssertionError

And the relevant piece of code:
def _get_description(fname, base):
     with open(fname) as f:
         one = None
         while True:
             line = f.readline().rstrip('\n')
             if not line:
                 continue
             if line.startswith(':') and line.endswith(':'):
                 continue
             one = line
             break
         two = f.readline().rstrip('\n')
         three = f.readline().rstrip('\n')
         assert one == three
         assert all(c=='=' for c in one)
         name, description = two.split('--', 1)
line 27:        assert name.strip() == base
         return description.strip()
