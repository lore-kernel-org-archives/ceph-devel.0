From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: NFS stale filehandles
Date: Wed, 2 Feb 2011 11:12:57 -0800
Message-ID: <AANLkTikD5D7nbG0Dnt56RAOYDwt=m_iqEXE6YDzEpuBm@mail.gmail.com>
References: <AANLkTi=-oE5r54Km5HNCS5zL9FXSedfb=NDO4RbLsn-y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52895 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792Ab1BBTNI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 14:13:08 -0500
Received: by vws16 with SMTP id 16so166617vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 11:13:06 -0800 (PST)
In-Reply-To: <AANLkTi=-oE5r54Km5HNCS5zL9FXSedfb=NDO4RbLsn-y@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Ahh from the module source... I'll add this to the wiki page:
http://ceph.newdream.net/wiki/Re-exporting_NFS

/*
 * NFS export support
 *
 * NFS re-export of a ceph mount is, at present, only semireliable.
 * The basic issue is that the Ceph architectures doesn't lend itself
 * well to generating filehandles that will remain valid forever.
 *
 * So, we do our best.  If you're lucky, your inode will be in the
 * client's cache.  If it's not, and you have a connectable fh, then
 * the MDS server may be able to find it for you.  Otherwise, you get
 * ESTALE.
 *
 * There are ways to this more reliable, but in the non-connectable fh
 * case, we won't every work perfectly, and in the connectable case,
 * some changes are needed on the MDS side to work better.
 */




On Wed, Feb 2, 2011 at 10:52 AM, Brian Chrisman <brchrisman@gmail.com> =
wrote:
> There seems to be a bug in the ceph kernel client NFS implementation.
> Triage: =A0using the same cluster/servers and client
> 1) export ceph filesystem via NFS, mount on client, copy over files
> and build --> stale filehandle/corruption issues
> 2) export ext filesystem via NFS (same server node as in #1), mount o=
n
> client, copy over files and build --> no problem
> 3) mount ceph locally on build client, copy over files and build --> =
no problem
>
> From this, it seems most likely that the problem lies in the kernel
> client NFS export code.
>
> Kernel 2.6.37rc8
> Mounting via NFSv4 (noticed other issues with directories disappearin=
g
> when previously testing with NFSv3 that I can retest after figuring
> this out)
> Other than kernel, systems are a rhel6 beta distro
> I wanted to check whether/what testing has been done of the export
> code thus far, and see whether this is a known issue.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
