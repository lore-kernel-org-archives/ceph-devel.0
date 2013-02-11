From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: File exists not handled in 0.48argonaut1
Date: Mon, 11 Feb 2013 14:21:12 -0800
Message-ID: <CA+jddaNJ8XRFBb1nO6c7sVdeXxnd95a0S7r8Yuj1gubLAR-_AQ@mail.gmail.com>
References: <CA+jddaOAmvuwG1naPF2e4vwBh240UfX4OW_3Z93r5sJD-rAPjQ@mail.gmail.com>
	<CA+jddaO5KmTY=_dc38Sq4UP8vsSKJsMGmvig2CfEVOhntiv2aw@mail.gmail.com>
	<CA+4uBUbt5FXbQQpyEBGqKcA9yL0ReVNMFxgD6C7auw7=COE5vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44107 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630Ab3BKWVM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 17:21:12 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so8370754iea.10
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 14:21:12 -0800 (PST)
In-Reply-To: <CA+4uBUbt5FXbQQpyEBGqKcA9yL0ReVNMFxgD6C7auw7=COE5vw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Since the attachment didn't work, apparently, here is a link to the log:

http://dl.dropbox.com/u/766198/error17.log.gz

On Mon, Feb 11, 2013 at 1:42 PM, Samuel Just <sam.just@inktank.com> wrote:
> I don't see the more complete log.
> -Sam
>
> On Mon, Feb 11, 2013 at 11:12 AM, Mandell Degerness
> <mandell@pistoncloud.com> wrote:
>> Anyone have any thoughts on this???  It looks like I may have to wipe
>> out the OSDs effected and rebuild them, but I'm afraid that may result
>> in data loss because of the old OSD first crush map in place :(.
>>
>> On Fri, Feb 8, 2013 at 1:36 PM, Mandell Degerness
>> <mandell@pistoncloud.com> wrote:
>>> We ran into an error which appears very much like a bug fixed in 0.44.
>>>
>>> This cluster is running version:
>>>
>>> ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>>>
>>> The error line is:
>>>
>>> Feb  8 18:50:07 192.168.8.14 ceph-osd: 2013-02-08 18:50:07.545682
>>> 7f40f9f08700  0 filestore(/mnt/osd97)  error (17) File exists not
>>> handled on operation 20 (11279344.0.0, or op 0, counting from 0)
>>>
>>> A more complete log is attached.
>>>
>>> First question: is this a know bug fixed in more recent versions?
>>>
>>> Second question: is there any hope of recovery?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
