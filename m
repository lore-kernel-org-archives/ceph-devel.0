From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Cmake and rpmbuild
Date: Fri, 29 Jul 2016 09:37:17 +0200
Message-ID: <3e265099-96bd-1b69-fdae-211319f2744d@digiware.nl>
References: <CAGrH30XYN5fsx4HojZf3QdEAyvLm+-7N=tKYJU13HhjLrrRToQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:51797 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbcG2HhV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Jul 2016 03:37:21 -0400
In-Reply-To: <CAGrH30XYN5fsx4HojZf3QdEAyvLm+-7N=tKYJU13HhjLrrRToQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gerard Braad <me@gbraad.nl>, ceph-users <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

On 29-7-2016 03:50, Gerard Braad wrote:
> Hi All,
> 
> 
> At the moment I am setting up CI pipelines for Ceph and ran into a
> small issue; I have some memory constrained runners (2G). So, when
> performing a build using do-cmake all is fine... the build might last
> long, but after an hour or two I am greeted with a 'Build succeeded'
> message, I gather the artifacts and all is well.
> 
> But when I do a rpmbuild, I have to rely on doing a make-dist, and
> then issue a rpmbuild targeting this tarball. However, in the same
> runners, this build will fail with "virtual memory exhausted". Is
> there anything I can do that does not immediately involve adding more
> memory?
> 
> If more information is needed, please let me know...

Hi Gerard,

Experience is that for the automake part you'd really need 8G to not run
into this problem. And be happy that your running GCC because Clang is
even more memory hungry.

--WjW


