From: Nathan Cutler <ncutler@suse.cz>
Subject: Redmine problem
Date: Wed, 8 Nov 2017 22:54:27 +0100
Message-ID: <7f49bc39-c717-273e-c2d2-adade2df172e@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbdKHVy3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Nov 2017 16:54:29 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Galloway <dgallowa@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <loic@dachary.org>

Hi David:

In order to automate creation of backport tracker issues, we use a tool 
written by Loic that is essentially a glorified python script. It has 
worked flawlessly for years. Today, all of a sudden, it started failing 
with

requests.exceptions.ConnectionError: ('Connection aborted.', error(104, 
'Connection reset by peer'))

This error message is emanating from the python-requests module, which 
is used to communicate with Redmine (probably via its REST API) over 
http. Apparently, the other side (i.e. tracker.ceph.com) is resetting 
the connection without warning.

Did something change recently on the server side? Like, in the last two 
or three days? If so, I'm curious to hear what, since it would probably 
help me to debug this issue.

Thanks,
Nathan
