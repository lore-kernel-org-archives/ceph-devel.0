From: Gregory Farnum <greg@inktank.com>
Subject: Re: Operation per second meanining
Date: Tue, 4 Jun 2013 09:30:42 -0700
Message-ID: <CAPYLRzgdfyyeb0MtiZDGGTawH40UO-HNa7-O_Um1hcpQj4EKGw@mail.gmail.com>
References: <51ADC0C1.5000105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:55541 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3FDQao convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 12:30:44 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so883467lbd.20
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jun 2013 09:30:42 -0700 (PDT)
In-Reply-To: <51ADC0C1.5000105@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 4, 2013 at 3:26 AM, Roman Alekseev <rs.alekseev@gmail.com> =
wrote:
> Hello,
>
> Please help me to understand op/s (operation per second) value in 'pg=
map
> v71520: 3352 pgs: 3352 active+clean; 212 GB data, 429 GB used, 23444 =
GB /
> 23874 GB avail; 89237KB/s wr, 24op/s' line?
> What does "operation" mean?

What it sounds like =97 the pgmap includes the aggregate number of
read/write/whatever ops done across the cluster which are reported in
its time period, and will derive an average from that to output. This
is distinctly not a precise dynamic assessment, though =97 think of it
as being an approximate activity gauge, not something you can query
dynamically for instantaneous stats.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
