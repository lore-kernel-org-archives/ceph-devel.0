From: Zack Cerza <zack@redhat.com>
Subject: Re: teuthology call for help
Date: Wed, 25 Mar 2015 12:25:56 -0400 (EDT)
Message-ID: <558522744.2839705.1427300756297.JavaMail.zimbra@redhat.com>
References: <5512CC20.6030202@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:41077 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbCYQ1A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Mar 2015 12:27:00 -0400
In-Reply-To: <5512CC20.6030202@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hey Loic,

Your fragment is definitely included. See:

http://qa-proxy.ceph.com/teuthology/loic-2015-03-25_12:05:20-upgrade:gi=
ant-x:stress-split-erasure-code-hammer---basic-vps/820668/orig.config.y=
aml

description: upgrade:giant-x:stress-split-erasure-code/{0-cluster/start=
=2Eyaml 1-giant-install/giant.yaml
  2-partial-upgrade/firsthalf.yaml 3-thrash/default.yaml 4-mon/mona.yam=
l 5-workload/ec-rados-default.yaml
  6-next-mon/monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3D=
jerasure-k=3D3-m=3D1.yaml
  distros/ubuntu_14.04.yaml}
[...]
task:
- rados:
    clients:
    - client.0
    ec_pool: true
    objects: 50
    op_weights:
      append: 100
      copy_from: 50
      delete: 50
      read: 100
      rmattr: 25
      rollback: 50
      setattr: 25
      snap_create: 50
      snap_remove: 50
      write: 0
    ops: 4000
- print: '**** done rados ec task'
tasks:
- chef: null
- clock.check: null
- install:
    branch: giant
- print: '**** done install giant'
[...]


The issue is that 5-workload/ec-rados-default.yaml uses the word 'task'=
 instead of 'tasks'.

Zack


----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Zack Cerza" <zcerza@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Wednesday, March 25, 2015 7:54:24 AM
Subject: teuthology call for help

Hi Zack,

I'm blocked with http://pulpito.ceph.com/loic-2015-03-25_12:05:20-upgra=
de:giant-x:stress-split-erasure-code-hammer---basic-vps/820668/ and nee=
d your help.

Do you understand why 5-workload/ec-rados-default.yaml is not included =
? It's like it does not exist. But it does :-)

Thanks in advance !

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
