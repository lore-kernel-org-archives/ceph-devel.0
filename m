From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Strange about radosgw-admin bucket link/unlink
Date: Fri, 10 Aug 2012 09:45:42 -0700
Message-ID: <CAC-hyiFAm6X+LWTrgPAoYO9uEdjPRs9ukNpm+CkRHGRAGhqJHQ@mail.gmail.com>
References: <CAKG+gh8OygctHM6aHzfXD-mnGOs-ftyfpo35sTZGQJSd4QQHRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58394 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab2HJQpo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Aug 2012 12:45:44 -0400
Received: by bkwj10 with SMTP id j10so672085bkw.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Aug 2012 09:45:43 -0700 (PDT)
In-Reply-To: <CAKG+gh8OygctHM6aHzfXD-mnGOs-ftyfpo35sTZGQJSd4QQHRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 9, 2012 at 11:28 PM, =E8=94=A1=E6=AC=8A=E6=98=B1 <chuanyu@c=
s.nctu.edu.tw> wrote:
> Hi,
>
> Is it a bug or my usage is wrong?
> When I link a bucket to another specified user, all bucket's contents
> are cleaned,
> on the other hand, after unlinking a bucket, original user still can
> access the bucket contents.
>
Looks like a bug. I opened issue #2935.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
