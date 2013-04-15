From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] Scrub shutdown the OSD process
Date: Mon, 15 Apr 2013 10:57:55 -0700
Message-ID: <CAPYLRzjz3FVvm5OH-TBN3R8tmv8LREFYKTEX41Zk7DTLjoPXkA@mail.gmail.com>
References: <1366018923.3018.3.camel@localhost>
	<CAPYLRziFNxnUhyxHRUCzZBF6oQwrWt8YdxBtDrKzMMNuyuW=YQ@mail.gmail.com>
	<1366046351.26980.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:45644 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3DOR54 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 13:57:56 -0400
Received: by mail-qa0-f42.google.com with SMTP id dx4so424995qab.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 10:57:55 -0700 (PDT)
In-Reply-To: <1366046351.26980.0.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Mon, Apr 15, 2013 at 10:19 AM, Olivier Bonvalet <ceph.list@daevel.fr=
> wrote:
> Le lundi 15 avril 2013 =E0 10:16 -0700, Gregory Farnum a =E9crit :
>> Are you saying you saw this problem more than once, and so you
>> completely wiped the OSD in question, then brought it back into the
>> cluster, and now it's seeing this error again?
>
> Yes, it's exactly that.
>
>
>> Are any other OSDs experiencing this issue?
>
> No, only this one have the problem.

Did you run scrubs while this node was out of the cluster? If you
wiped the data and this is recurring then this is apparently an issue
with the cluster state, not just one node, and any other primary for
the broken PG(s) should crash as well. Can you verify by taking this
one down and then doing a full scrub?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
