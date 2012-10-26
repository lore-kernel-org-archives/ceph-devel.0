From: Wido den Hollander <wido@widodh.nl>
Subject: Re: osd_pool_default_size
Date: Fri, 26 Oct 2012 15:41:04 +0200
Message-ID: <508A92F0.7040007@widodh.nl>
References: <CAOLwVUkvCQm-_UF=OsykCfw+CH7CPxBaXZrwDtH19M-T5EPrgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:53170 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932921Ab2JZNlI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 09:41:08 -0400
In-Reply-To: <CAOLwVUkvCQm-_UF=OsykCfw+CH7CPxBaXZrwDtH19M-T5EPrgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 10/26/2012 10:17 AM, S=E9bastien Han wrote:
> Hi Cephers!
>
> Some question about this parameter:
>
> - Why does this parameter need to be in the [mon] section to work?

It's the monitor who is preparing the new pool before creating it. I ha=
d=20
a discussion regarding this with Greg some time ago, can't re-call if=20
this was on IRC or the ml though.

It however contradicts what's in the docs:=20
http://ceph.com/docs/master/config-cluster/osd-config-ref/

The docs seem to be wrong at this point:

* src/mon/OSDMonitor.cc *

int OSDMonitor::prepare_new_pool(string& name, uint64_t auid, int=20
crush_rule,
                                  unsigned pg_num, unsigned pgp_num)
{
=2E.
=2E.
   pending_inc.new_pools[pool].size =3D g_conf->osd_pool_default_size;
=2E.
=2E.
}

This is done by the monitor.

There seems to be some reference for this in src/osd/OSDMap.cc, but tha=
t=20
seems to be for initializing the cluster since it creates the data,=20
metadata and rbd pool there.

This was fixed in this commit:=20
https://github.com/ceph/ceph/commit/1292436b8f88ce203bdba97278ce368b1df=
a025f

Seems to be because of this message on the ml last year:=20
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/2983

So yes, it is odd that something prefixed with "osd" should go into the=
=20
mon section.

Wido

> - In my ceph.conf I set a default size of 3:
>
> # rados mkpool lol
> successfully created pool lol
>
> # ceph osd dump | grep lol
> pool 31 'lol' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num =
8
> pgp_num 8 last_change 430 owner 18446744073709551615
>
> Now if I retrieve the admin daemon I get,
>
> # ceph --admin-daemon /var/run/ceph/ceph-osd.0.asok config show | gre=
p
> 'osd_pool_default_size'
> osd_pool_default_size =3D 2
>
> Why? Did I something wrong?
>
> Thanks :)
>
> Cheers!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
