From: Calvin Morrow <calvin.morrow@gmail.com>
Subject: Re: NFS over Ceph
Date: Mon, 23 Apr 2012 23:19:36 -0600
Message-ID: <CADxhoDR+WAWAQzS-7DTA5-9dy8sxmQByA2QnhF+CsMVsECBfbw@mail.gmail.com>
References: <CADxhoDTMQMrNBYE8PykjB4UCkCBmyXcUsKxnaXmfyYNbfr9-7A@mail.gmail.com>
	<Pine.LNX.4.64.1204231958020.9820@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64198 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2DXFTj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Apr 2012 01:19:39 -0400
Received: by wejx9 with SMTP id x9so154623wej.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Apr 2012 22:19:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204231958020.9820@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 23, 2012 at 9:01 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 23 Apr 2012, Calvin Morrow wrote:
>> I've been testing a couple different use scenarios with Ceph 0.45
>> (two-node cluster, single mon, active/standby mds). =A0I have a pair=
 of
>> KVM virtual machines acting as ceph clients to re-export iSCSI over
>> RBD block devices, and also NFS over a Ceph mount (mount -t ceph).
>>
>> The iSCSI re-export is going very well. =A0So far I haven't had any
>> issues to speak of (even while testing Pacemaker based failover).
>>
>> The NFS re-export isn't going nearly as well. =A0I'm running into
>> several issues with reliability, speed, etc. =A0To start with, file
>> operations seem painstakingly long. =A0Copying over multiple 20 Kb f=
iles
>> takes =A0> 10 seconds per file. =A0"dd if=3D/dev/zero of=3D'.... goe=
s very
>> fast once the data transfer starts, but the actual opening of the fi=
le
>> can take nearly as long (or longer depending on size).
>
> Can you try with the 'async' option in your exports file? =A0I think =
the
> main problem with the slowness is because of what nfsd is doing with
> syncs, but want to confirm that.
>

async didn't make a difference.  I thought this pretty strange, so I
decided to try mounting a separate dir with the ceph-fuse client
instead of the native kernel client.  What amounted was a night and
day difference.  I pushed a good 79 GB (my home directory) through the
nfs server (sync) attached to the fuse client at an average speed of
~68 MB / sec over consumer gigabit.

Just for completeness, I re-exported the native kernel client (after
verifying it could browse ok, read / write files, etc.) and I was back
to __very__ slow metadata ops (just a simple `ls` takes > 1 min).

Calvin

> Generally speaking, there is an unfortunate disconnect between the NF=
S and
> Ceph metadata protocols. =A0Ceph tries to do lots of operations and s=
ync
> periodically and on-demand (e.g., when you fsync() a directory). =A0N=
=46S,
> OTOH, says you should sync every operation, which is usually pretty
> horrible for performance unless you have NVRAM or an SSD or something=
=2E
>
> We haven't invested much time/thought into what the best behavior sho=
uld
> be, here... NFS is pretty far down are list at the moment.
>
> sage
>
>>
>> I've also run into cases where the directory mounted as ceph
>> (/mnt/ceph) "hangs" on the NFS server requiring a reboot of the NFS
>> server.
>>
>> That said, are there any special recommendations regarding exporting
>> Ceph through NFS? =A0I know that in the wiki and also (still present=
 as
>> of 3.3.3) kernel source indicates:
>>
>> * NFS export support
>> *
>> * NFS re-export of a ceph mount is, at present, only semireliable.
>> * The basic issue is that the Ceph architectures doesn't lend itself
>> * well to generating filehandles that will remain valid forever.
>>
>> Should I be trying this a different way? =A0NFS export of a filesyst=
em
>> (ext4 / xfs) on RBD? =A0Other options? =A0Also, does the filehandle
>> limitation specified above apply to more than NFS (such as a KVM ima=
ge
>> using a file on a ceph mount for storage backing)?
>>
>> Any insight would be appreciated.
>>
>> Calvin
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
