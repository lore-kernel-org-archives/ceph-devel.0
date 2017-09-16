From: Henrique Fingler <hfingler@cs.utexas.edu>
Subject: Re: How do I "install" from source? Service binaries (and /etc/ceph)
 are missing after make install
Date: Fri, 15 Sep 2017 20:09:31 -0400
Message-ID: <CACG+mBVDvoz3R2fBdb6RYifbvkkM6OBG8ii=VNMRgJaXvMCoOQ@mail.gmail.com>
References: <CACG+mBVY==QPieFqgP1Qf1tcibRJZS5LhU02Wsca+4q=o2EkFA@mail.gmail.com>
 <alpine.DEB.2.11.1709152355200.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from newman.cs.utexas.edu ([128.83.139.110]:57104 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdIPAJi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 20:09:38 -0400
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com [209.85.218.42])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id v8G09bxr032406
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 19:09:37 -0500
Received: by mail-oi0-f42.google.com with SMTP id r20so364874oie.0
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 17:09:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709152355200.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

>Try 'sudo make install' from the build dir.

 I did and some things are still missing, like services. What I found
is that the directory "/usr/lib/systemd/system" doesn't exist in my
ubuntu distro (issue also found here:
https://github.com/chef/chef-server/issues/572 ), so the service files
are never copied there. I created the dir and copied manually and now
I can see them with "systemctl list-unit-files", I can also enable the
monitor service but nothing starts when I try to do so, this is what
I'm trying to fix now.

>Probably better is to actually build a package with dpkg-buildpackage...

 Possibly, but I'm changing the code/recompiling pretty often and that
takes over an hour, on top of consuming 30+gb if I keep the /build
directory. (I'm on a budget on AWS :P)

 Thanks for the quick reply!



2017-09-15 19:57 GMT-04:00 Sage Weil <sage@newdream.net>:
> On Fri, 15 Sep 2017, Henrique Fingler wrote:
>> I made some modifications to the source code and I'm trying to deploy it.
>>
>>  The ceph-deploy fails because I dont want to do "ceph-deploy
>> install", and even if I run "sudo make install" some service binaries
>> are not found,  /etc/ceph and the dir on /var/ are not created.
>>
>>  So now I'm just trying to do a manual deploy and I can't do the
>> monitor part. I run everything, but when I try to actually launch the
>> monitor, I can't. The manual says to run "sudo start ceph-mon
>> id=node1" if I have ubuntu. Well, AWS's ubuntu doesn't use upstart so
>> that doesn't work. I then tried "sudo /etc/init.d/ceph start
>> mon.node1", but ceph doesn't exist in init.d.
>>
>>  How is it created and who does it? Is it a symlink to the binary? Why
>> doesn't "make install" do this automatically? Is there a script to do
>> the delta between installing from a package manager and installing
>> from source?
>
> Try 'sudo make install' from the build dir.  You might need to change the
> prefix to /usr from /usr/local.  If you want to install just like the
> package would (or as close as you can get), look at debian/rules to see
> what is passed to cmake during the build.
>
> Probably better is to actually build a package with dpkg-buildpackage...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
