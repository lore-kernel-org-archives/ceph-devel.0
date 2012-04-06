From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: defaults paths #2
Date: Fri, 6 Apr 2012 10:34:44 -0700
Message-ID: <CAORUGqBq93+nWutxEAb=uWmEqCpCPCjcRKrzkTY4rRPMhfX1Vw@mail.gmail.com>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
 <Pine.LNX.4.64.1204052204290.21401@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42749 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab2DFRfG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 13:35:06 -0400
Received: by vcqp1 with SMTP id p1so840788vcq.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Apr 2012 10:35:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204052204290.21401@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 5, 2012 at 22:12, Sage Weil <sage@newdream.net> wrote:
> Here's what I'm thinking:
>
> =C2=A0- No data paths are hard-coded except for /etc/ceph/*.conf
> =C2=A0- We initially mount osd volumes in some temporary location (sa=
y,
> =C2=A0 /var/lib/ceph/temp/$uuid)
> =C2=A0- We identify the oid, cluster uuid, etc., and determine where =
to mount
> =C2=A0 it with
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ceph-osd --cluster $cluster -i $id --show-=
config-value osd_data
>
> =C2=A0 This will normally give you the default, unless the conf file =
specified
> =C2=A0 something else.
> =C2=A0- Normal people get a default of /var/lib/ceph/$type/$id
> =C2=A0- Multicluster crazies put
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[global]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0osd data =3D /=
var/lib/ceph/$type/$cluster-$id
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0osd journal =3D=
 /var/lib/ceph/$type/$cluster-$id/journal
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mon data =3D /=
var/lib/ceph/$type/$cluster-$id
>
> =C2=A0 (or whatever) in /etc/ceph/$cluster.conf and get something els=
e.
>
> Code paths are identical, data flow is identical. =C2=A0We get a simp=
le general
> case, without closing the door on multicluster configurations, which =
vary
> only by the config value that is easily adjusted on a per-cluster bas=
is...

Except we lost features. Now I can't iterate the contents of a
directory and know what they mean. I think we'll need that.

Basically, there's two ways of using Ceph. One is "do what ever you
want", the other one is "managed". Managed needs to really know what
goes where. If you want managed mode to always enforce configuration
to contain osd data, osd journal, mon data, just to be safe, and for
it to break the very first moment a sysadmin edits the config file, we
can do that. But there's no way the managed mode is going to be able
to be fully featured if file locations are completely based on the
configuration file. I'd rather not have too many "must be here" items
in the config file, to tempt the admin into editing it. Nothing will
ever prevent the "do what ever you want" side, but I'd like the
defaults to fit the "managed" mode.

Think of it this way: ceph.conf with arbitrary contents is a one way
mapping. I expect to need a two-way mapping.

Or, I can just make managed mode *always* pass in explicit --osd-data
etc. Then ceph.conf won't matter. I wouldn't describe that as simpler,
though.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
