From: Sage Weil <sage@newdream.net>
Subject: Re: Still denc warnings in Clang
Date: Thu, 23 Mar 2017 12:16:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703231215590.30468@piezo.novalocal>
References: <3793fc2c-b971-7440-6448-219500e6f2a5@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32799 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdCWMQV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 08:16:21 -0400
In-Reply-To: <3793fc2c-b971-7440-6448-219500e6f2a5@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Oops, hasn't merged yet!

	https://github.com/ceph/ceph/pull/13889

Needs to go through the QA suite still.
sage


On Thu, 23 Mar 2017, Willem Jan Withagen wrote:

> I thought that all these warnings were eradicated by now?
> 
> --WjW
> 
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1162:10: warning:
> binding dereferenced null pointer to reference has undefined behavior
> [-Wnull-dereference]
>     denc(*(bool *)nullptr, p);
>          ^~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1169:10: warning:
> binding dereferenced null pointer to reference has undefined behavior
> [-Wnull-dereference]
>     denc(*(bool *)nullptr, p);
>          ^~~~~~~~~~~~~~~~
> /home/jenkins/workspace/ceph-master/src/include/denc.h:1236:10: warning:
> binding dereferenced null pointer to reference has undefined behavior
> [-Wnull-dereference]
>     denc(*(bool *)nullptr, p);
>          ^~~~~~~~~~~~~~~~
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
