From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: NFS of Gluster and Ceph
Date: Thu, 10 Mar 2011 10:02:43 -0800
Message-ID: <1E72DB85C40A4BE3A6FC6A02E09D9F33@gmail.com>
References: <AANLkTikxqzhANs3tHufbuNjOxh+CQhxqE6pG2nL=DVTH@mail.gmail.com>
 <121F588803854AE4A0B0E95E001F1D63@gmail.com>
 <AANLkTikVgP_n0cEEa4AHsL6zYbxjZaGvFuozB4XqV222@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60943 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab1CJSCs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 13:02:48 -0500
Received: by qwd7 with SMTP id 7so1444091qwd.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 10:02:47 -0800 (PST)
In-Reply-To: <AANLkTikVgP_n0cEEa4AHsL6zYbxjZaGvFuozB4XqV222@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On Thursday, March 10, 2011 at 7:45 AM, Sylar Shen wrote: 
> Hi Gregory,
> Here are my conditions:
> 1. I use in-kernel client(my OS is Fedora 14)
> 2. Replication level is 1, so there are 2 identical files(the original
> and the copy).
> 3. The network card on each server and the switch are 1Gb/s.
> 
> You said you'd expect mush faster results on the buffered write test,
> maybe approaching the network interface limits.
> I think you may misunderstand what I mean.
> I used the in-kernel client to mount Ceph(mount -t ceph 192.168.1.11:/
> /mnt/ceph) .
> I re-exported NFS on the client using "exportfs client:/mnt/ceph -o
> fsid=1234,rw,no_squash_root"
> Besides, I used another server to connect to the client by NFS
> protocol and did the write test using dd command(with buffer).
> And I got Ceph=46.6MB/s while Gluster=39.3MB/s, the speed looked similar.
> So this confuses me. Because I think even if Ceph is re-exported by
> NFS protocol, it should be a lot faster than Gluster.
> Did I do something wrong or was it really influenced by the speed of
> the switch or the router?
> Thanks in advance!

Hmm. We haven't run a lot of tests via NFS re-export, but Sage doesn't think it should impact performance too much. Could you try running those dd tests on the Ceph mount directly? We generally see results of 90MB/s to 110MB/s when running simple sequential write tests like that. It's possible that the machine you're using to export NFS from doesn't have a full-duplex card and so you're saturating its network interface, which would yield about 45MB/s writes like you're getting.
-Greg



