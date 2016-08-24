From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: should we remove autotools from master?
Date: Wed, 24 Aug 2016 11:44:51 +0200
Message-ID: <ac76726a-4645-959b-e635-2661ed70c521@digiware.nl>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
 <57BC5B7A.8050103@dachary.org>
 <DB5PR05MB16077097293BBD4CBF85D90EA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:21569 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755115AbcHXJw1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 05:52:27 -0400
In-Reply-To: <DB5PR05MB16077097293BBD4CBF85D90EA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>, Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Brad Hubbard <bhubbard@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Adir Lev <adirl@mellanox.com>

On 23-8-2016 17:11, Avner Ben Hanoch wrote:
> For removing autotools support, I think that we should first announce that autotools will not be supported starting <some-future-day> and till then support both of them in parallel and response to questions about it.
> 
> Also, we first need to make sure that we have comprehensive instructions for using cmake.
> Notice, that many developers are not familiar with cmake; hence, there might be need for extra explanations.
> 
> For example, I tried now the instructions in https://github.com/ceph/ceph/blob/master/README.md 
> 	./do_cmake.sh
> 	cd build
> 	make
> and I got the error:
> 	make: *** No targets specified and no makefile found.  Stop.
> 
> Probably, because of the explanation "This assumes you make your build dir a subdirectory of the ceph.git checkout. If you put it elsewhere, just replace .. above with a correct path to the checkout." However, if you are not familiar with cmake, then this explanation does not tell you how to recover from the error.
> 
> Also, I am not sure it is clear to all developers how to combine above instructions with options that you could provide to ./configure script.

eeeh,

Isn't ./configure part of the autotools and should that not also go?
Haven't used ./configure since I started using cmake, which is a big plus.

Note that you can put build/config options on the do_cmake.sh commandline.

--WjW


