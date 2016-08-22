From: Kefu Chai <kchai@redhat.com>
Subject: Re: releasing jewel v10.2.3 ?
Date: Mon, 22 Aug 2016 00:35:34 -0400 (EDT)
Message-ID: <499139327.3003480.1471840534716.JavaMail.zimbra@redhat.com>
References: <57B698D0.1050409@dachary.org> <1074794425.66535.1471591086293.JavaMail.open-xchange@ox03.mail.pcextreme.nl> <57BA0EC8.3050008@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:36763 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbcHVEfq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 00:35:46 -0400
In-Reply-To: <57BA0EC8.3050008@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: wido@42on.com, Ceph Development <ceph-devel@vger.kernel.org>, Samuel Just <sjust@redhat.com>



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: wido@42on.com, "Kefu Chai" <kchai@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Monday, August 22, 2016 4:27:52 AM
> Subject: Re: releasing jewel v10.2.3 ?
> 
> 
> Hi Wido,
> 
> Almost all pull requests requested for 10.2.3 are merged except this one.
> There is a backport at https://github.com/ceph/ceph/pull/10804 . It will
> need testing and it may take some time.
> 
> @Kefu Is there a job we can run to verify it does the right thing in jewel ?
> 

we do exercise "ceph osd pause" in workunit/cephtool[1], but we don't thrash
osds in the test suite[2] that testing this command.

@Sam, how about adding "ceph osd {pause,unpause}" calls to Thrasher in ceph_manager.py,
so the thrashosd tests can test it as well?

--
[1] suites/rados/singleton/all/cephtool.yaml
[2] suites/rados/singleton/

> Cheers
> 
> On 19/08/2016 09:18, wido@42on.com wrote:
> > 
> > 
> >> Op 19 aug. 2016 om 07:28 heeft Loic Dachary <loic@dachary.org> het
> >> volgende geschreven:
> >>
> >> Hi Sage,
> >>
> >> Here are the issues that would be in jewel v10.2.3 if we decided to
> >> release it now: http://tracker.ceph.com/versions/518
> >> And here is the backport queue :
> >> http://tracker.ceph.com/projects/ceph/issues?query_id=96
> >>
> >> Do you think it is time to cut the release and ask QE to start testing ?
> >>
> > 
> > I think that this one is a good candidate to go in as well. Since 10.2.4
> > can take a while.
> > 
> > http://tracker.ceph.com/issues/17023 /
> > https://github.com/ceph/ceph/pull/10725
> > 
> > Nasty one which might catch users and leave them wondering why the OSDs are
> > not coming up.
> > 
> > Wido
> > 
> >> Cheers
> >>
> >> --
> >> LoÃ¯c Dachary, Artisan Logiciel Libre
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> Loïc Dachary, Artisan Logiciel Libre
>
