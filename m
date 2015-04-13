From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: Ceph code tests
Date: Mon, 13 Apr 2015 08:57:36 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF01F23C52@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39162 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbbDMJCC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 05:02:02 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>
Cc: "Zhou, Yuan" <yuan.zhou@intel.com>

Hi Loic,=20

I'm trying to setup an internal Teuthology cluster here. I was able to =
setup a 3 node cluster now. however there's not much docs and I'm confu=
sed about some questions here:

1) how does Ceph upstream do tests? Currently I see there's a) Jekins(m=
ake check on each PR) b) Teuthology Integration tests(on important PR o=
nly).
2) Teuthology automatically fetch the binary files from gitbuilder.ceph=
=2Ecom currently. However the binary will not be built for each pull re=
quest?=A0=20
3) Can Teuthology working on VMs? I got some info from your blog, looks=
 like you're running Teuthology on a Openstack/Docker.
4) If I have a working Teuthology cluster now, how do I start a full ru=
n? or only the workunits/* is good enough?

Thanks for any hints!
-yuan

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
