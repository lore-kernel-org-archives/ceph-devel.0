From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Wed, 23 Mar 2016 11:12:00 +1100
Message-ID: <20160323001200.GA1244@onthe.net.au>
References: <1456913706999.87255@croc.ru>
 <56D6CF42.7080909@dachary.org>
 <20160310000006.GA14061@onthe.net.au>
 <20160316232029.GA22451@onthe.net.au>
 <011EEA5C-6A6B-489B-AB20-6EDEE2F55AFE@ebay.com>
 <20160317014314.GA25617@onthe.net.au>
 <20160322224923.GA31017@onthe.net.au>
 <56F1D1D3.8070207@dachary.org>
 <20160322233932.GA32084@onthe.net.au>
 <56F1DD3A.4000902@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:35553 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbcCWAMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 20:12:06 -0400
Content-Disposition: inline
In-Reply-To: <56F1DD3A.4000902@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Chen, Xiaoxi" <xiaoxchen@ebay.com>, Nathan Cutler <ncutler@suse.cz>, M Ranga Swami Reddy <swamireddy@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Lo=C3=AFc,

On Wed, Mar 23, 2016 at 01:03:06AM +0100, Loic Dachary wrote:
> On 23/03/2016 00:39, Chris Dunlop wrote:
>> "The old OS'es" that were being supported up to v0.94.5 includes deb=
ian
>> wheezy. It would be quite surprising and unexpected to drop support =
for an
>> OS in the middle of a stable series.
>=20
> I'm unsure if wheezy is among the old OS'es. It predates my involveme=
nt in the stable releases effort. I know for sure el6 and 12.04 are sup=
ported for 0.94.x.=20

=46rom http://download.ceph.com/debian-hammer/pool/main/c/ceph/

ceph-common_0.94.1-1~bpo70+1_i386.deb              15-Dec-2015 15:32   =
         10217628
ceph-common_0.94.3-1~bpo70+1_amd64.deb             19-Oct-2015 18:54   =
          9818964
ceph-common_0.94.4-1~bpo70+1_amd64.deb             26-Oct-2015 20:48   =
          9868020
ceph-common_0.94.5-1~bpo70+1_amd64.deb             15-Dec-2015 15:32   =
          9868188

That's all debian wheezy.

(Huh. I'd never noticed 0.94.1 was i386 only!)

Cheers,

Chris,
OnTheNet
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
