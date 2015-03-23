From: John Spray <john.spray@redhat.com>
Subject: Re: adding "{mds,mon} metadata" asok command
Date: Mon, 23 Mar 2015 10:35:22 +0000
Message-ID: <550FEC6A.1030208@redhat.com>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com> <alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net> <550FE53B.9050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47508 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbbCWKf1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Mar 2015 06:35:27 -0400
In-Reply-To: <550FE53B.9050407@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <jecluis@gmail.com>, Sage Weil <sage@newdream.net>, kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 23/03/2015 10:04, Joao Eduardo Luis wrote:
> I agree.  And I don't think we need a new service for this, and I also 
> don't think we need to write stuff to the store.  We can generate this 
> information when the monitor hits 'bootstrap()' and share it with the 
> rest of the quorum once an election finishes, and always keep it in 
> memory (unless there's some information that needs to be persisted, 
> but I was under the impression that was not the case).
Just to clarify, you mean we don't need to write the mon metadata to the 
store, but we'd still want to persist the MDS/OSD metadata - right?

John
