From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: wip-librbd-caching
Date: Wed, 18 Apr 2012 09:27:27 -0700
Message-ID: <59C9961D9B314E3E979F937368248BB3@dreamhost.com>
References: <4F872D48.6070801@tuxadero.com>
 <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
 <4F8EB889.4080106@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33905 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab2DRQ1b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 12:27:31 -0400
Received: by ghrr11 with SMTP id r11so3782035ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 09:27:31 -0700 (PDT)
In-Reply-To: <4F8EB889.4080106@tuxadero.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On Wednesday, April 18, 2012 at 5:50 AM, Martin Mailand wrote:
> Hi,
> =20
> I changed the values and the performance is still very good and the =20
> memory footprint is much smaller.
> =20
> OPTION(client_oc_size, OPT_INT, 1024*1024* 50) // MB * n
> OPTION(client_oc_max_dirty, OPT_INT, 1024*1024* 25) // MB * n (dirty =
=20
> OR tx.. bigish)
> OPTION(client_oc_target_dirty, OPT_INT, 1024*1024* 8) // target dirty=
 =20
> (keep this smallish)
> // note: the max amount of "in flight" dirty data is roughly (max - t=
arget)
> =20
> But I am not quite sure about the meaning of the values.
> client_oc_size Max size of the cache?
> client_oc_max_dirty max dirty value before the writeback starts?
> client_oc_target_dirty ???
> =20

Right now the cache writeout algorithms are based on amount of dirty da=
ta, rather than something like how long the data has been dirty. =20
client_oc_size is the max (and therefore typical) size of the cache.
client_oc_max_dirty is the largest amount of dirty data in the cache =E2=
=80=94 if this much is dirty and you try to dirty more, the dirtier (a =
write of some kind) will block until some of the other dirty data has b=
een committed.
client_oc_target_dirty is the amount of dirty data that will trigger th=
e cache to start flushing data out.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
