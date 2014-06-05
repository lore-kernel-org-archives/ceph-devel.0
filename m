From: Samuel Just <sam.just@inktank.com>
Subject: Mon backing store
Date: Thu, 5 Jun 2014 10:42:39 -0700
Message-ID: <CA+4uBUZaFHhyn9Brx=dM08qFgPFQiAohufpVk+GH5zCR9Hzb0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:33182 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaFERmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 13:42:40 -0400
Received: by mail-qa0-f44.google.com with SMTP id j7so1822490qaq.17
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jun 2014 10:42:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I am starting to wonder whether using leveldb for the mon is actually
introducing an excessive amount unnecessary complexity and
non-determinism.  Given that the monitor workload is read mostly,
except for failure conditions when it becomes write latency sensitive,
might we do better with a strict b-tree style backing db such as
berkely db even at the cost of some performance?  It seems like
something like that might provide more reliable latency properties.

Thoughts?
-Sam
