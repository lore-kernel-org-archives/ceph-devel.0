From: Wido den Hollander <wido@42on.com>
Subject: Zabbix plugin for ceph-mgr
Date: Mon, 26 Jun 2017 20:57:08 +0200 (CEST)
Message-ID: <1977676292.2763.1498503429028@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se04-out.mail.pcextreme.nl ([185.87.184.124]:43884 "EHLO
        se04-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751445AbdF0AyJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Jun 2017 20:54:09 -0400
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
