From: Andrey Korolyov <andrey@xdel.ru>
Subject: changed rbd cp behavior in 0.53
Date: Mon, 12 Nov 2012 19:30:27 +0300
Message-ID: <CABYiri8Hm2EjLsffgSp3aANPwVQ2FPYWx5q01Wkq7sk1Smp41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64086 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2KLQas (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 11:30:48 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6397382obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Nov 2012 08:30:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

For this version, rbd cp assumes that destination pool is the same as
source, not 'rbd', if pool in the destination path is omitted.

rbd cp install/img testimg
rbd ls install
img testimg


Is this change permanent?

Thanks!
