From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [ceph-commit] ceph.git branch master updated. v0.27.1-331-gd9ea95f
Date: Tue, 10 May 2011 14:20:08 -0700
Message-ID: <BANLkTimEBjoidJuu4_+NVPRMdK1jUcEcmA@mail.gmail.com>
References: <20110509222127.2B4DA485C521@ceph-tracker.dreamhostps.com>
	<BANLkTikviXrv_LHTnJ0QmsB0DtqKYoaoaQ@mail.gmail.com>
	<BANLkTikz-ZWCrAVu7E1c-3udHVdCb=fasA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41982 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1EJVUJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 17:20:09 -0400
Received: by fxm17 with SMTP id 17so4595998fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 14:20:08 -0700 (PDT)
In-Reply-To: <BANLkTikz-ZWCrAVu7E1c-3udHVdCb=fasA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Colin McCabe <cmccabe@ceph-tracker.dreamhostps.com>, ceph-devel@vger.kernel.org

Hi all.

As we noted earlier, "rados get" and "rados put" do gets and puts,
respectively. This is different from "export" and "import" which have
always synchronized whole pools.

I guess we can have syntax like this for the import and export:
rados sync [import|export] <options> <src> <dst>

I will implement that in a branch called
wip-merge-radostool-with-radossync and you can evaluate whether you
like it better than having a separate binary or not.

Colin


On Mon, May 9, 2011 at 4:29 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Mon, May 9, 2011 at 4:24 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> Ermm, doesn't rados sync do a whole tree sync or something? I think =
we
>> want to maintain a simple get/set object capability and the rados to=
ol
>> is a pretty logical place for that.
>> -Greg
> Sorry, Gmail got confused so I resent! :(
>
>
> On Mon, May 9, 2011 at 4:25 PM, Sage Weil <sage@newdream.net> wrote:
>> On Mon, 9 May 2011, Gregory Farnum wrote:
>>> Ermm, doesn't rados sync do a whole tree sync or something? I think=
 we
>>> want to maintain a simple get/set object capability and the rados t=
ool
>>> is a pretty logical place for that.
>>
>> The main difference with sync is that it does incremental updates (s=
kips
>> dup items).
>>
>> As an aside I we should move that into the rados tool, though ('rado=
s
>> sync' instead of 'rados_sync')...
> If it's that simple a syntax change, I agree. I thought rados_sync
> would require an empty directory if you just want to pull an object
> out, which was my main concern.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
