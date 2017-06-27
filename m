From: Wido den Hollander <wido@42on.com>
Subject: Zabbix plugin for ceph-mgr
Date: Tue, 27 Jun 2017 08:46:51 +0200 (CEST)
Message-ID: <1140178751.2772.1498546011538@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se01-out.mail.pcextreme.nl ([185.66.251.200]:50223 "EHLO
        se01-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751557AbdF0IDq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Jun 2017 04:03:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

After looking at the documentation [0] on how to write a plugin for ceph-mgr I've been playing with the idea to create a Zabbix [1] plugin for ceph-mgr.

Before I start writing one I'd like to check if I'm thinking in the right direction.

Zabbix supports Items and Triggers. Triggers are based on Items's values. A Item could be from the type 'Trapper' where a application can simply send key=value pairs, for example:

my.host.name ceph.health HEALTH_OK
my.host.name ceph.osd.up 499
my.host.name ceph.osd.in 498

A simple ceph-mgr module could do:

def serve(self):
  while True:
    send_data_to_zabbix()
    time.sleep(60)

Now, would that be a sane plugin for ceph-mgr or is this something you shouldn't put in the mgr? To me it seems like a good place since it already has all the data present.

Wido

[0]: http://docs.ceph.com/docs/master/mgr/plugins/
[1]: http://www.zabbix.com/
