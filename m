From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: File exists not handled in 0.48argonaut1
Date: Mon, 11 Feb 2013 11:12:03 -0800
Message-ID: <CA+jddaO5KmTY=_dc38Sq4UP8vsSKJsMGmvig2CfEVOhntiv2aw@mail.gmail.com>
References: <CA+jddaOAmvuwG1naPF2e4vwBh240UfX4OW_3Z93r5sJD-rAPjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42680 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820Ab3BKTMF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 14:12:05 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so8163609iec.18
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 11:12:04 -0800 (PST)
In-Reply-To: <CA+jddaOAmvuwG1naPF2e4vwBh240UfX4OW_3Z93r5sJD-rAPjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Anyone have any thoughts on this???  It looks like I may have to wipe
out the OSDs effected and rebuild them, but I'm afraid that may result
in data loss because of the old OSD first crush map in place :(.

On Fri, Feb 8, 2013 at 1:36 PM, Mandell Degerness
<mandell@pistoncloud.com> wrote:
> We ran into an error which appears very much like a bug fixed in 0.44.
>
> This cluster is running version:
>
> ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>
> The error line is:
>
> Feb  8 18:50:07 192.168.8.14 ceph-osd: 2013-02-08 18:50:07.545682
> 7f40f9f08700  0 filestore(/mnt/osd97)  error (17) File exists not
> handled on operation 20 (11279344.0.0, or op 0, counting from 0)
>
> A more complete log is attached.
>
> First question: is this a know bug fixed in more recent versions?
>
> Second question: is there any hope of recovery?
