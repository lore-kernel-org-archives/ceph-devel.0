From: Loic Dachary <loic@dachary.org>
Subject: Re: udev events on a disk, at boot time
Date: Wed, 22 Jun 2016 17:20:52 +0200
Message-ID: <576AACD4.80406@dachary.org>
References: <57695098.50403@dachary.org>
 <CAPed3OFeAJvLy+7G8YdwJ1pdi=p+tRatpPPQ=DmsvGjr-5QouA@mail.gmail.com>
 <57696DC1.3090803@dachary.org>
 <CAPed3OFyST0oJs0SQaxKXLRSu71YYPUTu+ZpKBmaEX2QaWri8g@mail.gmail.com>
 <576A8299.2000404@dachary.org>
 <CAPed3OGUMDjsDTZsb-eNBmoZ9Qjffdb8uXeYG=07Y4D9kbb8mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50445 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcFVPVV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 11:21:21 -0400
In-Reply-To: <CAPed3OGUMDjsDTZsb-eNBmoZ9Qjffdb8uXeYG=07Y4D9kbb8mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ruben Kerkhof <ruben@rubenkerkhof.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Yeah ! One more clue :-)

On 22/06/2016 17:07, Ruben Kerkhof wrote:
> On Wed, Jun 22, 2016 at 2:20 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>> One thing that might be different between our setups is that my roo=
t
>>> fs is on LVM. I'll reinstall a server just to see if that matters.
>>>
>>> Another workaround for this that works for me is running 'udevadm
>>> trigger -c add -s block' after boot, this mounts the ceph volumes
>>> successfully.
>>
>> Thanks for the additional information. It confirms that for some rea=
son I have ADD events in my test setup and you don't. Still digging.
>=20
> I now reinstalled a few servers with the root fs on a plain partition=
,
> to take LVM out of the equation, and the OSDs come up fine.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
