From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH 1/1 linux-next] ceph: fix bool assignments
Date: Thu, 09 Oct 2014 17:41:39 -0700
Message-ID: <54372B43.2010801@inktank.com>
References: <1412889395-19350-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412889395-19350-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org



On 10/09/2014 02:16 PM, Fabian Frederick wrote:
> Fix some coccinelle warnings:
> fs/ceph/caps.c:2400:6-10: WARNING: Assignment of bool to 0/1


> -	bool wake = 0;
> +	bool wake = false;

FWIW, that message is backwards: it should say "WARNING: Assignment of
0/1 to bool" (I know, it's a coccinelle issue, but..)
