From: Loic Dachary <loic@dachary.org>
Subject: aarch64 conditional ansible stanza
Date: Thu, 7 Apr 2016 08:46:51 +0200
Message-ID: <5706025B.3080205@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46354 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbcDGGrB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 02:47:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thierry Delamare <t.delamare@laposte.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Thierry,

In order to only install a template on architectures that are not aarch=
64, I changed

- name: Add sources list
  template:
    dest: /etc/apt/sources.list
    src: "../../templates/apt/sources.list.{{ ansible_distribution_rele=
ase | lower }}"
    owner: root
    group: root
    mode: 0644
  register: sources

into

- name: Add sources list
  template:
    dest: /etc/apt/sources.list
    src: "../../templates/apt/sources.list.{{ ansible_distribution_rele=
ase | lower }}"
    owner: root
    group: root
    mode: 0644
  register: sources
  when: {{ansible_architecture}} !=3D aarch64

Is there a better way to do that ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
