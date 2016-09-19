From: Alfredo Deza <adeza@redhat.com>
Subject: Re: ceph v10.2.3 QE validation status
Date: Mon, 19 Sep 2016 16:36:58 -0400
Message-ID: <CAC-Np1yDLkQ0OFkroTYXosY8GMvdtX5tW6m5a_9R+eh2Jj1U2A@mail.gmail.com>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
 <CAMMFjmFo=1B07c3czD41CkNUWR8htfSn9z5vwcpdJuVZjbtAyQ@mail.gmail.com>
 <alpine.DEB.2.11.1609151816540.19761@piezo.us.to> <CAMMFjmF-t1-CgwpEcmaLSei8tycsK03eY5jSt8ppVR8N3+AUwg@mail.gmail.com>
 <CAMMFjmHjddnyeS6tu5s4SuH+hLBQvnr5-GDuRd=LjDwDYUn80A@mail.gmail.com> <CAMMFjmHdLYZ+Yk4EMfBfPwaYBjEq6CFokDKpRkKQuS88fU+cfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38085 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752847AbcISUhB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 16:37:01 -0400
Received: by mail-wm0-f50.google.com with SMTP id l132so30303172wmf.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 13:37:00 -0700 (PDT)
In-Reply-To: <CAMMFjmHdLYZ+Yk4EMfBfPwaYBjEq6CFokDKpRkKQuS88fU+cfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>, Jeff Layton <jlayton@redhat.com>

On Mon, Sep 19, 2016 at 4:12 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Alfredo, Sage
>
> All failed jobs/issues had been addressed/approved (details in
> http://tracker.ceph.com/issues/16344#note-46) and jewel ceph v10.2.3
> is ready for release.

We are unable to cut a release because Jewel is not building on Xenial.

There are issues in the code that creates a virtualenv for
ceph-disk/ceph-detect-init that uses Python wheels that needs to be
corrected. Andrew and I have
been trying to fix this issue on the Jenkins side, but at this point
we have asked Loic to step in because we haven't been able to get a
workaround.

See http://tracker.ceph.com/issues/16169

>
> Thx
> YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
