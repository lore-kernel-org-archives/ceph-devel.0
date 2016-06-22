From: Samuel Just <sjust@redhat.com>
Subject: Re: new gitbuilder system outline
Date: Wed, 22 Jun 2016 08:45:52 -0700
Message-ID: <CAN=+7FX4qEqU9_BHjJSK_5i2r1Hjsk7tCVD7T6nB3VBCVLXsRA@mail.gmail.com>
References: <CAEPMp+6vB+EO9f_HvoxobsuPJhE11HBUOHTts9YdaZsxHAhfhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35718 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcFVPqt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 11:46:49 -0400
Received: by mail-qk0-f172.google.com with SMTP id c73so70410281qkg.2
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 08:45:53 -0700 (PDT)
In-Reply-To: <CAEPMp+6vB+EO9f_HvoxobsuPJhE11HBUOHTts9YdaZsxHAhfhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sounds great!
-Sam

On Wed, Jun 22, 2016 at 8:32 AM, Andrew Schoen <aschoen@redhat.com> wrote:
> All,
>
> As you may or may not know Alfredo and I have been working on
> designing a new system to replace the gitbuilders. I wanted to send
> out an outline of what we're thinking to gather review and feedback.
> We're hoping this new system will be able to produce a test build much
> faster than the current solution and scale easily as the ceph core
> team grows.
>
> Components of the new gitbuilder system.
>
> - Jenkins
>   - responsible for building ceph and uploading the binaries to chacra
>   - provides an interface to initiate builds
>   - provides authentication and authorization on who can initiate builds
>
> - Chacra
>   - responsible for storage of the binaries and repo creation
>   - can be scaled horizontally by creating new nodes and registering
> them with Shaman
>
> - Shaman
>   - responsible for coordination between the chacra nodes.
>   - responsible for acting as a load balancer for all the chacra
> nodes. This is so  jenkins can know which node to upload binaries to
> and to allow for the ability for    chacra nodes to scale
> horizontally.
>   - responsible for answering questions about the availability of ceph
> repos. (i.e. What is the latest sha1 I can test for the master branch
> on xenial, trusty and centos7? Is sha1 X built for xenial?)
>   - provides metadata about ceph repositories,
>
> - Mita
>   - responsible for creating new jenkins slaves.
>   - responsible for tearing down unused jenkins slaves.
>
> - Prado
>   - responsible for provisioning of new jenkins slaves
>
> Basic workflow of a "gitbuilder like" ceph build, from initiation to
> repo ready for use:
>
> - Jenkins build initiated
>   - By sha1 or branch
>   - upstream release or dev release (gitbuilder build)
>   - provide list of distros
> - Jenkins performs the build
> - Jenkins asks Shaman which chacra instance to upload binaries to
>   - Shaman will know all the chacra nodes and will provide them for
> use in a round robin fashion by use of an api endpoint.
> - Jenkins uploads binaries to chacra instance given by shaman
> - When repo creation is queued, chacra will ping shaman to notify it
> that a repo has been requested.
> - When repo creation starts, chacra will ping shaman with that status.
> - If repo creation fails, chacra will notify shaman.
> - If repo creation succeeds, chacra will notify shaman.
> - Shaman can be queried for status of the repos by ref, sha1 or distro.
>   - Shaman can answer questions like, "What is the latest sha1 I can
> use for the master branch on trusty, xenial and centos7?"
>
> Best,
> Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
