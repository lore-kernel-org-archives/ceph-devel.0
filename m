From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 22:17:45 +0100
Message-ID: <CAJH6TXhLWzgLS_RK5GNpsNpbzF=QiaEV8-3CwmvG2ZHEWdekQg@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
	<CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
	<CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
	<CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com>
	<CAJH6TXiLpvN4cD829P8njm6z9YkQXtpKWpYoFWsCAHQO1N+Dow@mail.gmail.com>
	<CAMm-wcJTfubebF=W+GCHdHM9kvZ6b9pGWpMv-Ri0-Pn7XQ-SeQ@mail.gmail.com>
	<CAJH6TXjE=nQscexL34fQ7RA0sDVc4+QB_O1r39UUAJ5_q87+OQ@mail.gmail.com>
	<CAMm-wcJox33ZvdfQMT-UN75g5tmGjkbLzPvcbJNmC0-jD1rKVw@mail.gmail.com>
	<CAJH6TXg=DpmE8O24TPtQwPL3MsEaqqdxBsnhS1zAFmjgRbUYrQ@mail.gmail.com>
	<50904154.7080004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35375 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934532Ab2J3VRq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 17:17:46 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so408695eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 14:17:45 -0700 (PDT)
In-Reply-To: <50904154.7080004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

2012/10/30 Dan Mick <dan.mick@inktank.com>:
> Generally that's considered OK.  ceph-mon doesn't use very much disk or CPU
> or network bandwidth.

In this case, should I reserve some space to ceph-mon (a partition or
a dedicated disk) or ceph-mon is able to 'share' the osd disk space
automatically (for example using a directory)?
