From: Dan Mick <dan.mick@inktank.com>
Subject: Re: teuthology : ulimit: error
Date: Fri, 09 Aug 2013 22:35:38 -0700
Message-ID: <5205D12A.4090408@inktank.com>
References: <52041335.9040009@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:56185 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab3HJFf5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Aug 2013 01:35:57 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so5200501pbc.37
        for <ceph-devel@vger.kernel.org>; Fri, 09 Aug 2013 22:35:56 -0700 (PDT)
In-Reply-To: <52041335.9040009@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

IIRC we had to adjust settings in /etc/security to allow ulimit 
adjustment of at least core:

sed -i 's/^#\*.*soft.*core.*0/\*                soft    core 
unlimited/g' /etc/security/limits.conf

or something like that.  That seems to apply to centos/fedora/redhat 
systems.


On 08/08/2013 02:52 PM, Loic Dachary wrote:
> Hi,
>
> Trying to use Ubuntu precise virtual machines as teuthology targets ( making sure they have 2GB of RAM because ceph-test-dbg will not even install with 1GB of RAM ;-) and installing the key with
>
> wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
>
> teuthology runs with
>
> ./virtualenv/bin/teuthology job.yaml
>
> where job.yaml is
>
> check-locks: false
> roles:
> - - mon.a
>    - mon.c
>    - osd.0
> - - mon.b
>    - osd.1
>    - client.0
> tasks:
> - install:
>     project: ceph
>     branch: wip-5510
> - ceph:
>     fs: ext4
> - workunit:
>      clients:
>        all:
>        - filestore/filestore.sh
> targets:
>     ubuntu@91.121.254.229: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOSit20EyZ2AKCvk2tnMsdQ6LmVRutvBmZb0awV9Z2EduJa0fYPrReYRb9ZhGRq2PJe0zgpFPKr8s4gGay+tL0+dFkju5uyABqMGeITlJCifd+RhM0MCVllgIzekDwVb0n6ydTS8k7GVFyYv8ZC0TPgbfcDcEtSEgqJNRJ0o1Bh8swuTn+cipanNDRVK39tOqJdfptUxak+TD+5QY8CGFdXdEQYP7VsYJ+jQHw73O2xbuPgfv5Shbmt+qGWLToxFqKca3owMtkvFeONgYUdujgg9qr7Q9p0+HhCFCXB8v4N2I7NSbWNdpGqyJLdLqwJ70gEeNlOhm5F7IsXfVxTapB
>     ubuntu@91.121.254.237: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXVzhedORtmEmCeZJ4Ssg8wfqpYyH9W/Aa+j6CvPHSAkzZ48zXqVBATxm6S8sIIqfKkz1hWpNssx6uUotbm8k/ZatMddsd932+Di136l/HUhp6O8iIFze56kjWpyDpRPw2MM0V+OKmsiHZDfMj9ATt6ChgXfRsm23MUlmnoFHvtfwvFBnvBjcZPN7qxMpFHDamZzACNvnis/OINJrud9VprOgjhZZ7mxcTbcVZaVgcTcnyC4b9d9PRrMG2aCv0BO1eb/qnlmSogQPfoKEORJcwaUcLgabww+Taa9hJSZ9l8yEQamj+XIgr6yzGKgCvlG4lTdHM2tQdpgATZvR7/pBz
>
> and produces the following output
>
> INFO:teuthology.orchestra.run.err:[91.121.254.229]: /home/ubuntu/cephtest/lo1308082328/adjust-ulimits: 4: ulimit: error setting limit (Operation not permitted)
>
> and the full output is at
>
> http://pastealacon.com/32957
>
> as if
>
> /home/ubuntu/cephtest/lo1308082328/adjust-ulimits ceph-coverage /home/ubuntu/cephtest/lo1308082328/archive/coverage monmaptool --create --clobber --add a 91.121.254.229:6789 --add c 91.121.254.229:6790 --add b 91.121.254.237:6789 --print /home/ubuntu/cephtest/lo1308082328/monmap'
>
> was run without a leading sudo. I tried running sudo adjust-ulimits echo foo manually on the target and it works.
>
> I would very much appreciate a hint ;-)
>
> Cheers
>
