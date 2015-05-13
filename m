From: Gregory Meno <gmeno@redhat.com>
Subject: Re: [ceph-calamari] Does anyone understand Calamari??
Date: Tue, 12 May 2015 17:02:54 -0700
Message-ID: <607C9580-DF69-4CA0-9D65-550700893CA8@redhat.com>
References: <7E8CF9C16F722345A89076330719CB1F4A82525D@EXMAIL1.taec.toshiba.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42964 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbbEMAC6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 20:02:58 -0400
In-Reply-To: <7E8CF9C16F722345A89076330719CB1F4A82525D@EXMAIL1.taec.toshiba.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bruce McFarland <Bruce.McFarland@taec.toshiba.com>
Cc: "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

Bruce,

It is great to hear that salt is reporting status from all the nodes in=
 the cluster.

Let me see if I understand your question:

You want to know what conditions cause us to recognize a working cluste=
r?

see https://github.com/ceph/calamari/blob/master/cthulhu/cthulhu/manage=
r/manager.py#L135

https://github.com/ceph/calamari/blob/master/cthulhu/cthulhu/manager/ma=
nager.py#L349

and

https://github.com/ceph/calamari/blob/master/cthulhu/cthulhu/manager/cl=
uster_monitor.py


Let=E2=80=99s check that you need to be digging into that level of deta=
il:

You switched to a new instance of calamari and it is not recognizing th=
e cluster.

You what to know what you are overlooking? Would you please clarify wit=
h some hostnames?

i.e. Let say that your old calamari node was called calamariA and that =
your new node is calamariB

from which are you running the get_heartbeats?

what is the master setting in the minion config files out on the nodes =
of the cluster if things are setup correctly they would look like this:

[root@node1 shadow_man]# cat /etc/salt/minion.d/calamari.conf=20
master: calamariB


If this is the case the thing I would check is the http://calamariB/api=
/v2/cluster endpoint is reporting anything?

hope this helps,
Gregory

> On May 12, 2015, at 4:34 PM, Bruce McFarland <Bruce.McFarland@taec.to=
shiba.com> wrote:
>=20
> Increasing the audience since ceph-calamari is not responsive. What s=
alt event/info does the Calamari Master expect to see from the ceph-mon=
 to determine there is an working cluster? I had to change servers host=
ing the calamari master and can=E2=80=99t get the new machine to recogn=
ize the cluster. The =E2=80=98salt \* ceph.get_heartbeats=E2=80=99 retu=
rns monmap, fsid, ver, epoch, etc for the monitor and all of the osd=E2=
=80=99s. Can anyone point me to docs or code that might enlighten me to=
 what I=E2=80=99m overlooking? Thanks.
> _______________________________________________
> ceph-calamari mailing list
> ceph-calamari@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-calamari-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
