From: Yehuda Sadeh <yehuda@inktank.com>
Subject: blueprint: rgw multitenancy
Date: Mon, 29 Jul 2013 18:05:10 -0700
Message-ID: <CABBk=J9zCqNgQ6HOaYpBNxijn9noh=JtBifs2J+i9OZiXeSdTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:39686 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab3G3BFK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 21:05:10 -0400
Received: by mail-vb0-f47.google.com with SMTP id h10so3243307vbh.6
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 18:05:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I created a new blueprint that discusses rgw multitenancy. The rgw
multitenancy defines a level of hierarchy on top of users and their
data which provides the ability to separate the users into different
organizational entities.

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw:_multitenancy

As with the other blueprints, if you wish to participate please add
yourself as an interested party to the blueprint.

Yehuda
