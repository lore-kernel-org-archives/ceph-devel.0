From: Fabio Kaminski <fabiokaminski@gmail.com>
Subject: ceph block pointer abstractions
Date: Wed, 27 Apr 2011 16:18:22 -0300
Message-ID: <BANLkTimWV7QUUa7tQkzLO688XvMYKFKshQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59752 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab1D0TSX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 15:18:23 -0400
Received: by fxm17 with SMTP id 17so1351396fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 12:18:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Suppose that i have a datastructure with a block pointer to another
item(block)..
how this pointer would work with ceph, if this block get moved to
another data node, would it still work?

what is the best way to do it under ceph? im using cephs own userland libs..

block pointers? its safe? how.. :)

thanks,

Fabio Kaminski
