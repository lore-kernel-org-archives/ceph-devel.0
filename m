From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: MDS crash, wont startup again
Date: Thu, 17 May 2012 14:38:25 -0700
Message-ID: <4FB56FD1.5090805@inktank.com>
References: <CA+WUqKxZoh_5k5qgtUFwnsr2=gaZ4_RONazYQG7enKa75WhNVQ@mail.gmail.com> <CA+WUqKyFusqxiPkPvQeSaP_nPBd5_ab4nLz1xWeOZZqMLk1SBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52197 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab2EQVi2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 17:38:28 -0400
Received: by dady13 with SMTP id y13so2955136dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 14:38:28 -0700 (PDT)
In-Reply-To: <CA+WUqKyFusqxiPkPvQeSaP_nPBd5_ab4nLz1xWeOZZqMLk1SBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Felix Feinhals <ff@turtle-entertainment.de>
Cc: ceph-devel@vger.kernel.org

On 05/16/2012 01:11 AM, Felix Feinhals wrote:
> Hi again,
>
> anything on this Problem? Seems that the only choice for me is to
> reinitialize the whole cephfs (mkcephfs...)
> :(

Hi Felix, it looks like your first mail never reached the list.

> 2012/5/10 Felix Feinhals<ff@turtle-entertainment.de>:
>> Hi List,
>>
>> we installed a ceph cluster with ceph version 0.46.
>> 3 OSDs, 3 MONs and 3 MDSs.
>>
>> After copying a bunch of files to a ceph-fuse mount all MDS daemons
>> crash and now i cant bring them back online.
>> I already tried to restart the daemons in different order and also
>> removed one OSD, nothing really happened only now we have pgs with
>> active+remapped which i think is normal.
>> Any hints?

Are all three MDS active? At this point, more than one active MDS is
likely to crash. You can have one active and others standby.

If you've got only one active, what was the backtrace of the crash?
It'll be at the end of the MDS log (by default in /var/log/ceph).
