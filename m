Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776368;
	b=4+oHqru21m4LW8QYmBaaVXmBoK0ojjxGsPN6vMarjEnhjDZ0iQ31w7Q+Ygtzp3JQJtiF
	 bWEIDqGuZyWjCpsZ/YYBJcpQIuQZQOnvUrpwP/ubb3O9gfCJmzOS7zpEADat8+07rqb/D
	 qCUG0Xq6M0H9p4+N+NiYi/pNxmvMtkLyUc39s/tanxw9tcyM2+yHsjDc75usgoZORBJea
	 VKjqeNPDxtvUFom+lx3zxl7jUiiwkKpW3WVGyMmRKkOpai+4zXRpc67eGN6MbeP4lPdwT
	 RPWKZ86Z9gx4f4ue/xqpTJnEqarp1g0lUDMZX6esdm6Ow1LxmHjCmJOxZoXS/Ggpihg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776368;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IKNzvyVMLYtEt06BAvSl9wyQ4CJcpVFii/pE9jSKtKI=;
	b=SY/3TmoEpyjVZYTshZwOEb2r6wSXuoHk5ukBeCco7pg8duniYlp3LPz7tvtZTsGHrdIl
	 Qvsn5gEQ8E6TxjiUcwgxgHWAXP01UxkpLWxQ4/+PY86wVfrjfsn/MzZOUNlfqyWvtTC7H
	 h8vAzjklL5zYMKUHjIU2P1AQ8BOz1KIaZbCyEES1fk8+Eq9q/sTBIwiluKvCFayvUxZSF
	 82KHcFawWwv4b+9R120+MNpviVA9hatCELiKWFSwoItbgW+RNMquvgs+bbXEQ5dTzinmL
	 VyMkDZNhIBbVvWbissVIehOgGH5pV5LO6MbDqQda+GxjSMiW9BysebZllIINt44jPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoarIybA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FD606A31B
	for <ceph-devel@vger.kernel.org>; Wed,  4 Nov 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoarIybA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EA41F000C1;
	Wed,  4 Nov 2026 07:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776367;
	bh=IKNzvyVMLYtEt06BAvSl9wyQ4CJcpVFii/pE9jSKtKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CoarIybA4N16aSD/eyfbreH+m+9ghyqz6UuVBZyy3+TR/fIO0v3ZXT5tqJiEoON/8
	 T0pNiXBdvrH9S17SGcD0GL5ZFpluwVeQqNevcIn4A66+ekodPa/ftK3IBfRzMFMlVZ
	 lZ8nUgHtjlKRGpz/g4EHHaaxED1EoH9JejPiqyTk1XTSmqmRP3FZZJ9KJ9igP3OwNy
	 0knNRqZEesfj359Y09f15Wwe32Xyx7wHRLTJbTJB7kVaZkd/I8hldKRhYlatkn4Y38
	 n9wMziJmFMhbtp9vaFPUgHZbmppXgo5W8NjZZQT5OmPT75mgwoNeBEhpQdSP0gV5z+
	 uH7iVog/kZa8g==
Date: Wed, 4 Nov 2026 08:12:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>, Ilya Dryomov <idryomov@gmail.com>, 
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph: drop the mds request if the inline read getattr
 fails
Message-ID: <20261104-debonair-cinnamon-curassow-eaca1f@quoll>
References: <20261104021529.1468722-1-vulab@iscas.ac.cn>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104021529.1468722-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:15:29 +0000, Wentao Liang wrote:
> ceph_netfs_issue_op_inline() creates an MDC request with
> ceph_mdsc_create_request(), which returns it with the caller's
> reference, and hands it to ceph_mdsc_do_request().  The reference is
> dropped with ceph_mdsc_put_request() on every path that uses the reply,
> but the error return of ceph_mdsc_do_request() jumps straight to the
> out label.
> 
> A failed getattr - a killed MDS session, an interrupted request or a
> reply parsing error - therefore leaks the request and everything it
> holds, including the inode reference it took, on each inline read of a
> small file.
> 
> Release the request on that path as the other callers of
> ceph_mdsc_do_request() do.
> 
> Fixes: 5b19f1eba459 ("ceph: make ceph_netfs_issue_op() handle inlined data")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  fs/ceph/addr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




