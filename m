From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: the osd overload result in mds cannot reply client quickly
Date: Tue, 19 Apr 2011 09:08:20 -0700
Message-ID: <BANLkTi=MnJ5OMxPZdERVA0d_DbC51pUj5Q@mail.gmail.com>
References: <BANLkTin6RVew30zBExj55-LftkScudg=EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43750 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab1DSQIW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2011 12:08:22 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 39BD4C065
	for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2011 09:08:22 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id DF208C063
	for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2011 09:08:21 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1748470ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2011 09:08:20 -0700 (PDT)
In-Reply-To: <BANLkTin6RVew30zBExj55-LftkScudg=EQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Apr 19, 2011 at 2:56 AM, huang jun <hjwsm1989@gmail.com> wrote:
> hi,developers
> =A0 =A0i mount a new client and create a new directory when the osds =
are
> overload. in gerenal ,mds needs to return a safe
> message to the client( not return unsafe message to client at this
> time), but in this condition(OSD overloads) ,it takes too long to wai=
t
> for OSD finish =A0OSD_Op ,so the MDS can not immediatly answer the
> client the safe message, is there any resolutions about this problem?
> if did, in which model should =A0i =A0try it ,OSD or MDS?
Nope, if the OSDs are slow the MDS just has to wait for them. Doing
anything else could result in data loss!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
