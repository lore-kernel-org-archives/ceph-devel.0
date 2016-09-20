From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph v10.2.3 QE validation status
Date: Tue, 20 Sep 2016 10:45:44 +0200
Message-ID: <57E0F738.9080706@dachary.org>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
 <CAMMFjmFo=1B07c3czD41CkNUWR8htfSn9z5vwcpdJuVZjbtAyQ@mail.gmail.com>
 <alpine.DEB.2.11.1609151816540.19761@piezo.us.to>
 <CAMMFjmF-t1-CgwpEcmaLSei8tycsK03eY5jSt8ppVR8N3+AUwg@mail.gmail.com>
 <CAMMFjmHjddnyeS6tu5s4SuH+hLBQvnr5-GDuRd=LjDwDYUn80A@mail.gmail.com>
 <CAMMFjmHdLYZ+Yk4EMfBfPwaYBjEq6CFokDKpRkKQuS88fU+cfA@mail.gmail.com>
 <CAC-Np1yDLkQ0OFkroTYXosY8GMvdtX5tW6m5a_9R+eh2Jj1U2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56885 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753626AbcITIpw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 04:45:52 -0400
In-Reply-To: <CAC-Np1yDLkQ0OFkroTYXosY8GMvdtX5tW6m5a_9R+eh2Jj1U2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <loic@dachary.org>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>, Jeff Layton <jlayton@redhat.com>



On 19/09/2016 22:36, Alfredo Deza wrote:
> On Mon, Sep 19, 2016 at 4:12 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Alfredo, Sage
>>
>> All failed jobs/issues had been addressed/approved (details in
>> http://tracker.ceph.com/issues/16344#note-46) and jewel ceph v10.2.3
>> is ready for release.
> We are unable to cut a release because Jewel is not building on Xenial.
>
> There are issues in the code that creates a virtualenv for
> ceph-disk/ceph-detect-init that uses Python wheels that needs to be
> corrected. Andrew and I have
> been trying to fix this issue on the Jenkins side, but at this point
> we have asked Loic to step in because we haven't been able to get a
> workaround.
>
> See http://tracker.ceph.com/issues/16169
It looks like this is a combo of jenkins providing a machine that is poluted by a previous job and the fact that it does not run install-deps.sh. The discussion continues in the tracker.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre

