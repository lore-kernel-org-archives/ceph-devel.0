From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Better anticipation for minor releases
Date: Mon, 5 Feb 2018 13:32:46 -0800
Message-ID: <CAMMFjmHqDuVhP4R4VBbarZV3AZ0Kh3pb9xA5EJ9kybX0KMCGXA@mail.gmail.com>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com> <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
 <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz> <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
 <robbat2-20180202T195241-795645967Z@orbis-terrarum.net> <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz>
 <CAEPMp+4mVJd6155ZykTUmrgupLAvoLFEPUTBLVY26Hk+anXogA@mail.gmail.com>
 <alpine.DEB.2.11.1802051529210.24931@piezo.novalocal> <CALqRxCwD199oo-=TGsnNgy5vLAaFyD2sqqX2YSjtJx9AVZtLQg@mail.gmail.com>
 <alpine.DEB.2.11.1802051624220.15996@piezo.novalocal> <8a320a2d-71a2-84e3-79c0-1839c4cd7391@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pl0-f45.google.com ([209.85.160.45]:33568 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeBEVcr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 16:32:47 -0500
Received: by mail-pl0-f45.google.com with SMTP id t4so12648576plo.0
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 13:32:47 -0800 (PST)
In-Reply-To: <8a320a2d-71a2-84e3-79c0-1839c4cd7391@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Sage Weil <sage@newdream.net>, Ken Dreyer <kdreyer@redhat.com>, Andrew Schoen <aschoen@redhat.com>, "Robin H. Johnson" <robbat2@gentoo.org>, Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

That looks good, Nathan!

I would add one more point after 1:
1. release preparation phase begins, PRs cut off date communicated.
1.5.  PRs cut off date reached, no more PRs accepted


On Mon, Feb 5, 2018 at 1:20 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Git branches remove any concern for
>> "races".  If someone pushed 100 commits to luminous, just create a
>> different branch with exactly the commit(s) you *do* want and build from
>> that.  After everything is confirmed built, good, and tagged, push and
>> merge it back into the luminous stream.
>
>
> Sage makes a good point here, but I don't agree with the "remove any concern
> for races" part. In practice, I'm envisioning that it would work like this
> (substitute "jewel", "mimic" etc. for luminous):
>
> 1. release preparation phase begins
> 2. lots of PRs/commits are merged into luminous
> 3. release preparation phase ends with declaration of a "release candidate"
> SHA1
> 4. a luminous-rc branch is created from this SHA1
> 5. QE phase begins
> 6. all QE work takes place in luminous-rc
> 7. any QE-related fixes are merged into luminous-rc
> 8. QE phase ends with declaration of a "release" SHA1 which is (almost - see
> below) guaranteed to be the tip of luminous-rc
> 9. tag/build phase begins
> 10. tag is applied to, and packages built from, tip of luminous-rc (as
> usual, except luminous-rc instead of luminous)
> 11. tag/build phase ends - point release is out
> 12. luminous-rc is merged into luminous
>
> Granted, this does eliminate racing PRs in luminous, but it's still possible
> for something to get merged into luminous-rc after step 8 and before step
> 11, so the problem doesn't go away - it just gets less likely.
>
> Nathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
