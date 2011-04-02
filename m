From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: HEALTH_WARNING
Date: Sat, 2 Apr 2011 23:04:33 +0800
Message-ID: <AANLkTimwMj6zprkW0u8brSn2dCVw6CUnrGPRa=H4HXti@mail.gmail.com>
References: <1463999357.13436.1301740919511.JavaMail.root@mail.linserv.se>
	<718796783.13438.1301741738011.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60987 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab1DBPEe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2011 11:04:34 -0400
Received: by fxm17 with SMTP id 17so3154365fxm.19
        for <ceph-devel@vger.kernel.org>; Sat, 02 Apr 2011 08:04:33 -0700 (PDT)
In-Reply-To: <718796783.13438.1301741738011.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel@vger.kernel.org

> The only way I know to recover is to create a new filesystem in the cluster :-)
> But it's bad fot the data :-)
>
> When i get problems with one osd it seems as if they are crashing one by one.
> And i dont know how to get them up again whitout deleting all the data.
>

Which version of ceph are you running? We had similar problem before.
I would like to know if recent fixes for osd recovery (>= v0.25.1)
have already resolved this problem.

Thanks,
Henry
