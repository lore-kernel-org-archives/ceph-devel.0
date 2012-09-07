From: Ian Pye <ianpye@gmail.com>
Subject: Telling an osd to reload a cls library
Date: Thu, 6 Sep 2012 18:17:41 -0700
Message-ID: <CAEVWPAVfRk-2pg0RATzH8ph0zqXWrodm4viWhjDHJh3+P-zh7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52961 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab2IGBRn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 21:17:43 -0400
Received: by lbbgj3 with SMTP id gj3so1553601lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Sep 2012 18:17:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Is there a way to tell an osd to reload a cls.so file without
re-starting the osd?

Thanks,

Ian
