From: Samuel Just <sjust@redhat.com>
Subject: Re: Adding "chance_test_backfill_full" thrasher in the ec tasks
Date: Mon, 1 Jun 2015 11:18:39 -0400 (EDT)
Message-ID: <1131392043.10604321.1433171919792.JavaMail.zimbra@redhat.com>
References: <CAMxOGo076WPLnvo+peo=KmDpZUY2Qt34_vXMzgMQqF_TAcEWEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:57246 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbFAPTq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2015 11:19:46 -0400
In-Reply-To: <CAMxOGo076WPLnvo+peo=KmDpZUY2Qt34_vXMzgMQqF_TAcEWEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shylesh kumar <shylesh.mohan@gmail.com>
Cc: loic@dachary.org, ceph-devel@vger.kernel.org

Yep, that should be included in the ec thrashing tests.
-Sam

----- Original Message -----
From: "shylesh kumar" <shylesh.mohan@gmail.com>
To: "Samuel Just" <sjust@redhat.com>, loic@dachary.org
Cc: ceph-devel@vger.kernel.org
Sent: Saturday, May 30, 2015 8:27:20 AM
Subject: Adding "chance_test_backfill_full" thrasher in the ec tasks

Hi ,

As per discussion with loic none of the ec tests have
"chance_test_backfill_full" thrasher in the tasks, do you think it
would be a good idea to add it which can simulate disk space
scenarios.



-- 
Thanks
Shylesh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


