From: Alex Elder <elder@inktank.com>
Subject: Re: rbd kernel module crashes with different kernels
Date: Wed, 19 Dec 2012 18:16:04 -0600
Message-ID: <50D258C4.1050200@inktank.com>
References: <CAE63xUPhEy96cDSjhzk+DiRQ_bijNG3Pquj_1BW2NRqbjMp9dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:61167 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab2LTAQI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 19:16:08 -0500
Received: by mail-ia0-f171.google.com with SMTP id k27so2329648iad.16
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 16:16:07 -0800 (PST)
In-Reply-To: <CAE63xUPhEy96cDSjhzk+DiRQ_bijNG3Pquj_1BW2NRqbjMp9dQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/19/2012 05:17 PM, Ugis wrote:
> Hi all,
> 
> I have been struggling to map ceph rbd images for last week, but
> constantly get kernel crashes.
> 
> What has been done:
> Previously we had v0.48 set up as test cluster(4 hosts, 5 osds, 3
> mons, 3 mds, custom crushmap) on Ubuntu 12.04 and client Ubuntu
> Precise for mapping rbd+iscsi export, can't remember exact kernel
> version when crashes appeared. At some point it was no longer possible
> to map rbd images - on command "rbd map..." machine just crashed with
> lots of dumped info on screen. Same rbd map commands that worked
> before started to crash kernel at some point.

We'll want to get some of this detail to try to understand
exactly what's going on.

> I red some advices on list to use kernels 3.4.20. or 3.6.7. as those
> should have all known rbd module bugs fixed. I used one of those(I
> believe 3.6.7.) and managed to map rbd images again for couple of
> days. Then I discovered slow disk I/O on one host and removed OSD from
> it and moved that OSD to other new host(following doc.). For time of
> doing this rbd images were mapped. As I was busy moving osd I didn't
> notice moment when client crashed again, but I think that was some
> time after cluster had already recovered from degraded state after
> adding new osd.

OK.  This is good to know.

> After this point I could not map rbd images from client no more - on
> command "rbd map..." system just crashed. Reboots after crash did not
> help.
> I installed fresh Ubuntu Precise+3.6.7. kernel on spare box, crushes
> remained, then set up VM with Ubuntu Precise + tried kernels mentioned
> below and still got 100% crashes on "rbd map..." command.

> Well, those are blurry memories of problem history, but during last
> days I tried to solve problem by updating all possible components - it
> did not help neither unfortunately.
> 
> What I have tried:
> I completely removed demo cluster data(dd over osd data partitions,
> journal partitions, rm for rest files, purged+upgraded ceph packages
> to ceph version 0.55.1(8e25c8d984f9258644389a18997ec6bdef8e056b)) as
> update was planned anyway. So ceph is now 0.55.1 on Ubuntu 12.04+xfs
> for osds.
> Then I compiled kernels 3.4.20, 3.4.24, 3.6.7, 3.7.1 for client and
> tried to map rbd image - constant crash with all versions.

Let's try to narrow down the scope to just one version.  Let's
go with the 3.7.1 kernel you're using.  Is it the stock version
of that code, with commit id cc8605070a?

> Interesting part about map command itself - as I installed new rbd
> client box and  VM  I copy/pasted "rbd map.." commands that worked at
> very beginning to these machines.

Are the crashes you are seeing happening in the VM guest,
or in the host, or both?  Here too I'd like to work with
just one environment, to avoid confusion.  Whichever is
easiest for you works fine for me.

> Command was "rbd map fileserver/testimage  -k /etc/ceph/ceph.keyring",
> but this command still crashes kernel even now when there is no rbd
> "testimage"(I recreated pool "fileserver").
> Crash happens on command "rbd map notexistantpool/testimage  -k
> /etc/ceph/ceph.keyring" as well. Could that be some issue with
> backward compatibility as mapping like this was done on versions ago.
> 
> Then I decided to try different mapping syntax. Some intro+results:
> # rados lspools
> data
> metadata
> rbd
> fileserver
> 
> # rbd ls -l
> NAME             SIZE PARENT FMT PROT LOCK
> testimage1_10G 10000M          1
> 
> # rbd ls -l --pool fileserver
> rbd: pool fileserver doesn't contain rbd images

Normally the pool name is "rbd" for rbd images.
Unless you specified something different you can
just use "rbd", or don't specify it.  I.e.:

    # rbd ls -l
or
    # rbd ls -l --pool rbd

> well, I do not understand what in doc
> (http://ceph.com/docs/master/rbd/rbd-ko/) is meant by "myimage" so I
> am ommiting that part, but in no way kernel should crash if wrongly
> passed command has been given.
> Excerpt from doc:
> sudo rbd map foo --pool rbd myimage --id admin --keyring /path/to/keyring
> sudo rbd map foo --pool rbd myimage --id admin --keyfile /path/to/file
> 
> My commands:
> "rbd map testimage1_10G --pool rbd --id admin --keyring
> /etc/ceph/ceph.keyring" -> crash
> "rbd map testimage1_10G --pool rbd --id admin --keyfile
> /tmp/secret"(only key extracted from keyring and writen to
> /tmp/secret) -> crash
> 
> As crashes happen in client side and are immediate - I have no logs
> about it. I can post screenshots from console when crash happens, but
> they all are almost the same, containing strings:
> "Stack: ...
> Call Trace:...

This is the stuff I want to see.  A screenshot, if readable,
would be just fine, but if you can extract the information
in text form it would be best.

Also, if you can provide information about your configuration,
how many osd's, etc.  (or your ceph.conf file).

> Fixing recursive fault but reboot is needed!"
> 
> Also, when VM crashes - virtualization still shows high CPU
> load(probably some loop?)
> I tried default and custom CRUSH maps, but crashes are the same.
> 
> If anyone could advice how to get out of this magic compile
> kernel->"rbd map.."->crash cycle - I would be happy :)
> Probaby someone can reproduce crashes with similar commands? If I can
> send any additional valuable info to track down the problem - please
> let me know what is needed.
> 
> BR,
> Ugis

With a little more information it'll be easier to try to
explain what's going wrong.  We'll hopefully get you going
again and with any luck also be sure nobody has similar problems.

					-Alex

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

