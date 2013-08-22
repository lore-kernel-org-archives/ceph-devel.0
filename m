From: Nulik Nol <nuliknol@gmail.com>
Subject: Re: app design recommendations
Date: Thu, 22 Aug 2013 03:45:30 -0500
Message-ID: <CAHO6xe96siYjPxcUPE8DUXB23WrGdb7vNM0iJ7Xjm5OhobWpBQ@mail.gmail.com>
References: <CAHO6xe-FSmZdFTqDq56U9_QQ_hoPMnPqbFLjT1CLGETz-hCs7A@mail.gmail.com>
	<52147F10.3030509@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:33870 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab3HVIpb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 04:45:31 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so742856eek.25
        for <ceph-devel@vger.kernel.org>; Thu, 22 Aug 2013 01:45:30 -0700 (PDT)
In-Reply-To: <52147F10.3030509@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

Hi.
Thanks to everybody for the replies, I figured out what to do now.


> I'm not sure about the answer on this one, but you are aware of the fact
> that you can't search for objects? You can't ask RADOS to give you all
> objects where attr X has value Y.


Well, the main daily operation is to read the last 50 emails, and it
consumes about 95% of the system's resources, so I am going to offset
advanced search functions to an RDBMS and content search to sphinx,
gaining additional data copy in case of a disaster and saving in
development time.

Regards
Nulik
